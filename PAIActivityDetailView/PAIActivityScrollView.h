//
//  PAIActivityScrollView.h
//  PAIActivityDetailView
//
//  Created by bo on 15/11/24.
//  Copyright © 2015年 com.pencho.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PAIActivityScrollView : UIImageView

// 记录在superView 中的层级关系
@property (nonatomic,assign)NSInteger index;
- (void)setSourceImage:(id)objec;
@end
