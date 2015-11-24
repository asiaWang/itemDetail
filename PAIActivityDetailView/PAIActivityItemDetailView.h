//
//  PAIActivityItemDetalView.h
//  PAIActivityDetailView
//
//  Created by bo on 15/11/23.
//  Copyright © 2015年 com.pencho.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PAIActivityItemDetailViewDelegate <NSObject>

@optional
- (void)scrollViewDidSelectedNewItem:(id)newItem;

@end

@interface PAIActivityItemDetailView : UIView

// 当前页面展示的item
@property (nonatomic,strong,readonly)id frontShowItem;
@property (nonatomic,weak)id<PAIActivityItemDetailViewDelegate>delegate;
@property (nonatomic,copy)void (^clickToBuyBlock)();
@end
