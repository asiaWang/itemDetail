//
//  PAIActivityScrollView.m
//  PAIActivityDetailView
//
//  Created by bo on 15/11/24.
//  Copyright © 2015年 com.pencho.com. All rights reserved.
//

#import "PAIActivityScrollView.h"

@implementation PAIActivityScrollView

- (void)setSourceImage:(id)objec {
    
    if ([objec isKindOfClass:[UIImage class]]) {
        [self setImage:(UIImage *)objec];
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
