//
//  PAIActivityItemScrollView.h
//  PAIActivityDetailView
//
//  Created by bo on 15/11/24.
//  Copyright © 2015年 com.pencho.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PAIActivityItemScrollViewDelegate <NSObject>
@optional
- (void)scrollViewDidChangedFrontItem:(id)item;

@end

@interface PAIActivityItemScrollView : UIView
@property (nonatomic,weak)id<PAIActivityItemScrollViewDelegate>delegate;
- (void)setSourceItems:(NSArray *)itemsArray;
@end
