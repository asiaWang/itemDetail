//
//  PAICustomLabel.m
//  PAIActivityDetailView
//
//  Created by bo on 15/11/26.
//  Copyright © 2015年 com.pencho.com. All rights reserved.
//

#import "PAICustomLabel.h"

@implementation PAICustomLabel

- (CGRect)textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines {
    self.numberOfLines = numberOfLines;
    self.contentMode = UIViewContentModeTopLeft;
    return CGRectMake(3, 0, bounds.size.width - 6, bounds.size.height - 6);
}

- (void)drawTextInRect:(CGRect)rect {
    return [super drawTextInRect:UIEdgeInsetsInsetRect(CGRectMake(0, 0, rect.size.width, rect.size.height - 5), UIEdgeInsetsMake(-15, 0, 0, 0))];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
