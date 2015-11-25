//
//  PAIActivitySingleDetailViewViewController.h
//  PAIActivityDetailView
//
//  Created by bo on 15/11/23.
//  Copyright © 2015年 com.pencho.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PAIActivitySingleDetailViewViewController : UIViewController

// 当前屏幕的截图
- (void)setSourceSnapShotImage:(UIImage *)snapImage;
- (void)setItemIds:(NSArray *)itemIdArray;
@end
