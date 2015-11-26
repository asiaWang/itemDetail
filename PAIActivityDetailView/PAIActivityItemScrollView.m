//
//  PAIActivityItemScrollView.m
//  PAIActivityDetailView
//
//  Created by bo on 15/11/24.
//  Copyright © 2015年 com.pencho.com. All rights reserved.
//

#import "PAIActivityItemScrollView.h"
#import "PAIActivityScrollView.h"

static CGFloat constSize = 125.f;

typedef NS_ENUM(NSInteger,ScrollDirectionType) {
    ScrollDirectionType_Right,
    ScrollDirectionType_Left,
};

@interface PAIActivityItemScrollView()
@property (nonatomic,strong)NSMutableArray *sourceArray;
@property (nonatomic,strong)NSMutableArray *itemViewArray;
@property (nonatomic,strong)PAIActivityScrollView *currentScrollView;

@property (nonatomic,assign)BOOL startScroll;
@property (nonatomic,assign)CGPoint startPoint;
@property (nonatomic,assign)CGPoint startCenter;

@property (nonatomic,assign)CGFloat indexWidth;
@end

@implementation PAIActivityItemScrollView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        self.backgroundColor = [UIColor clearColor];
        _startScroll = NO;
    }
    return self;
}

- (NSMutableArray *)sourceArray {
    if (!_sourceArray) {
        _sourceArray = [NSMutableArray array];
    }
    return _sourceArray;
}

- (NSMutableArray *)itemViewArray {
    if (!_itemViewArray) {
        _itemViewArray = [NSMutableArray array];
    }
    return _itemViewArray;
}

- (void)setSourceItems:(NSArray *)itemsArray {
    if (itemsArray && itemsArray.count > 0) {
        if (self.sourceArray.count > 0) {
            [self.sourceArray removeAllObjects];
        }
        [self.sourceArray  addObjectsFromArray:itemsArray];
        [self initSubItemViews];
    }
}

- (void)initSubItemViews {
    
    self.indexWidth = 0;
    if (self.sourceArray.count > 1) {
        self.indexWidth = (self.frame.size.width - constSize) / self.sourceArray.count;
    }
    
    if (self.subviews.count > 0) {
        for (id object in self.subviews) {
            if ([object isKindOfClass:[PAIActivityScrollView class]]) {
                PAIActivityScrollView *scrollView = (PAIActivityScrollView *)object;
                [scrollView removeFromSuperview];
                scrollView = nil;
            }
        }
    }
    
    for (int i = 0; i < self.sourceArray.count; i++) {
        PAIActivityScrollView *scrollView = [[PAIActivityScrollView alloc] init];
        scrollView.tag = i;
        scrollView.index = i;
        scrollView.layer.borderWidth = .5f;
        scrollView.layer.borderColor = [UIColor grayColor].CGColor;
        if (self.sourceArray.count > 1) {
            scrollView.frame = CGRectMake(self.indexWidth * i, 0, constSize, constSize);
        }else {
            scrollView.frame = CGRectMake(0, 0, constSize, constSize);
        }
        if (i == 0) {
            self.currentScrollView = scrollView;
        }else {
//            scrollView.layer.
        }
        [scrollView setImage:[UIImage imageNamed:self.sourceArray[i]]];
        [self.itemViewArray addObject:scrollView];
        [self addSubview:scrollView];
        [self sendSubviewToBack:scrollView];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (self.sourceArray.count == 0 || self.currentScrollView == nil) {
        return;
    }
    
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self];
    self.startScroll = CGRectContainsPoint(self.currentScrollView.frame, touchPoint);
    if (self.startScroll) {
        self.startPoint = touchPoint;
        self.startCenter = self.currentScrollView.center;
    }
    
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (!self.startScroll) {
        return;
    }
    
    UITouch *touch = [touches anyObject];
    CGPoint tPoint = [touch locationInView:self];
    
    CGFloat distense = tPoint.x - self.startPoint.x;
    [self scrollViewDistense:(distense / 160)];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self];
    
    CGFloat distense = touchPoint.x - self.startPoint.x;
    if (ABS(distense) < 50) {
        [self reChangeItemListViewsFrame];
    }else {
        if (distense > 0) {
            //向右滑动
            [self scrollToDirectionType:ScrollDirectionType_Right];
        }else {
            //向左滑动
            [self scrollToDirectionType:ScrollDirectionType_Left];
        }
    }
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (!self.startScroll) {
        return;
    }
    [self reChangeItemListViewsFrame];
}

- (void)scrollViewDistense:(CGFloat)distense {
    CGPoint currCenter = self.startCenter;
    currCenter.x += 100 *distense;
    self.currentScrollView.transform = CGAffineTransformRotate(CGAffineTransformMakeTranslation(0, 0), 0.2 *distense);
}

// 滑动中途取消
- (void)reChangeItemListViewsFrame {
    [UIView animateWithDuration:0.2f animations:^{
        for (int i = 0; i < self.itemViewArray.count; i++) {
            PAIActivityScrollView *imageView = (PAIActivityScrollView *)self.itemViewArray[i];
            imageView.transform = CGAffineTransformIdentity;
            [imageView setFrame:CGRectMake(self.indexWidth * i, 0, constSize, constSize)];
            imageView.alpha = 1.0;
        }
    } completion:^(BOOL finished) {
        
    }];
}

// 滑动之后重设 self subviews 的frame
- (void)scrollToDirectionType:(ScrollDirectionType)type {

    CGFloat distense = self.currentScrollView.center.x - 80;
    [UIView animateWithDuration:(distense / 1000) animations:^{
        if (type == ScrollDirectionType_Left) {
            [self.currentScrollView setFrame:CGRectMake(-80, self.currentScrollView.frame.origin.y + 40, CGRectGetWidth(self.currentScrollView.bounds), CGRectGetHeight(self.currentScrollView.bounds))];
        }else {
            [self.currentScrollView setFrame:CGRectMake(80, self.currentScrollView.frame.origin.y + 40, CGRectGetWidth(self.currentScrollView.bounds), CGRectGetHeight(self.currentScrollView.bounds))];
        }
        self.currentScrollView.alpha = 0;
    } completion:^(BOOL finished) {
        self.currentScrollView.transform = CGAffineTransformIdentity;
        [self sendSubviewToBack:self.currentScrollView];
        [self.itemViewArray removeObjectAtIndex:0];
        [self.itemViewArray addObject:self.currentScrollView];
        self.currentScrollView = (PAIActivityScrollView *)self.itemViewArray[0];
        if ([self.delegate respondsToSelector:@selector(scrollViewDidChangedFrontItem:)]) {
            [self.delegate scrollViewDidChangedFrontItem:self.sourceArray[self.currentScrollView.tag]];
        }
        [self reChangeItemListViewsFrame];
    }];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
