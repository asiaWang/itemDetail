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
@property (nonatomic,strong)PAIActivityScrollView *currentScrollView;

@property (nonatomic,assign)BOOL startScroll;
@property (nonatomic,assign)CGPoint startPoint;
@property (nonatomic,assign)CGPoint startCenter;
@end

@implementation PAIActivityItemScrollView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
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
    
    CGFloat indexWidth = 0;
    if (self.sourceArray.count > 1) {
        indexWidth = (self.frame.size.width - constSize) / self.sourceArray.count;
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
        if (self.sourceArray.count > 1) {
            scrollView.frame = CGRectMake(indexWidth * i, 0, constSize, constSize);
        }else {
            scrollView.frame = CGRectMake(0, 0, constSize, constSize);
        }
        if (i == 0) {
            self.currentScrollView = scrollView;
        }
        [self addSubview:scrollView];
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
        self.currentScrollView.transform = CGAffineTransformIdentity;
        self.currentScrollView.frame = CGRectMake(0, 0, constSize, constSize);
    } completion:^(BOOL finished) {
        
    }];
}

// 滑动之后重设 self subviews 的frame
- (void)scrollToDirectionType:(ScrollDirectionType)type {
    NSArray *subViews = self.subviews;
    NSInteger startCount = subViews.count - 1;
    
    for (NSInteger i = startCount; i >= 0; i--) {
        id object = subViews[i];
        if ([object isKindOfClass:[PAIActivityScrollView class]]) {
            PAIActivityScrollView *imageView = (PAIActivityScrollView *)object;
            if (imageView.index == self.currentScrollView.index) {
                NSLog(@"最后一个subview 位当前屏幕的第一个View");
            }
        }
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
