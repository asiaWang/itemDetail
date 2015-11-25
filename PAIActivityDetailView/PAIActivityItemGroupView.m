//
//  PAIActivityItemGroupView.m
//  PAIActivityDetailView
//
//  Created by bo on 15/11/23.
//  Copyright © 2015年 com.pencho.com. All rights reserved.
//

#import "PAIActivityItemGroupView.h"

@interface PAIActivityItemGroupView()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (strong,nonatomic)NSMutableArray *sourceArray;
@end

@implementation PAIActivityItemGroupView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.pageControl.hidesForSinglePage = YES;
    self.scrollView.delegate = self;
}

- (NSMutableArray *)sourceArray {
    if (!_sourceArray) {
        _sourceArray = [NSMutableArray array];
    }
    return _sourceArray;
}

- (void)setSourceData:(NSArray *)array {
    if (array && array.count > 0) {
        if (self.sourceArray.count > 0) {
            [self.sourceArray removeAllObjects];
        }
        [self.sourceArray addObjectsFromArray:array];
        [self initSubViews];
    }
}

- (void)initSubViews {
    self.scrollView.contentSize = CGSizeMake(self.frame.size.width * self.sourceArray.count, self.frame.size.height);
    self.pageControl.numberOfPages = self.sourceArray.count;
    
    if (self.scrollView.subviews.count > 0) {
        for (id object in self.scrollView.subviews) {
            if ([object isKindOfClass:[UIImageView class]]) {
                UIImageView *imageView = (UIImageView *)object;
                [imageView removeFromSuperview];
                imageView = nil;
            }
        }
    }
    
    for (int i = 0; i < self.sourceArray.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width * i, 0, self.frame.size.width, self.frame.size.width)];
        imageView.tag = i;
        imageView.userInteractionEnabled = YES;
        [imageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",self.sourceArray[i]]]];
        if (i == 0) {
            NSLog(@"添加下载图片");
        }
        [self.scrollView addSubview:imageView];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSInteger index = fabs(scrollView.contentOffset.x) / scrollView.frame.size.width;
    self.pageControl.currentPage = index;
    [self.pageControl updateCurrentPageDisplay];
    
    for (id object in self.scrollView.subviews) {
        if ([object isKindOfClass:[UIImageView class]]) {
            UIImageView *imageView = (UIImageView *)object;
            if (imageView.tag == index) {
                NSLog(@"添加下载图片");
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
