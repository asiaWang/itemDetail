//
//  PAIActiviryItemView.h
//  PAIActivityDetailView
//
//  Created by bo on 15/11/23.
//  Copyright © 2015年 com.pencho.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PAIActiviryItemViewDelegate <NSObject>
@optional
- (void)dissMiss;
- (void)clickToBuyWithItem:(id)item;

@end

@interface PAIActiviryItemView : UIView
@property (weak, nonatomic)id<PAIActiviryItemViewDelegate>delegate;

- (void)setNeedsDisplayItems:(NSArray *)itemArray;
@end
