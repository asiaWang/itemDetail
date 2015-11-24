//
//  PAIActivitySingleDetailViewViewController.m
//  PAIActivityDetailView
//
//  Created by bo on 15/11/23.
//  Copyright © 2015年 com.pencho.com. All rights reserved.
//

#import "PAIActivitySingleDetailViewViewController.h"
#import "PAIActiviryItemView.h"

@interface PAIActivitySingleDetailViewViewController ()<PAIActiviryItemViewDelegate>

@property (nonatomic,strong)UIImageView *snapShotBackView;
@property (nonatomic,strong)PAIActiviryItemView *itemView;


#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_8_0
@property (nonatomic,strong)UIVisualEffectView *blutView;
#else
// 如果ios8 以下的如果需要
#endif

@end

@implementation PAIActivitySingleDetailViewViewController

- (UIImageView *)snapShotBackView {
    if (!_snapShotBackView) {
        _snapShotBackView = [[UIImageView alloc] initWithFrame:[UIApplication sharedApplication].keyWindow.bounds];
        _snapShotBackView.userInteractionEnabled = YES;
        _snapShotBackView.backgroundColor = [UIColor whiteColor];
    }
    return _snapShotBackView;
}

- (PAIActiviryItemView *)itemView {
    if (!_itemView) {
        _itemView = [[PAIActiviryItemView alloc] init];
        _itemView.frame = [UIApplication sharedApplication].keyWindow.bounds;
        _itemView.delegate = self;
    }
    return _itemView;
}

- (void)setSourceSnapShotImage:(UIImage *)snapImage {
    if (snapImage) {
        [self.snapShotBackView setImage:snapImage];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.snapShotBackView setImage:[UIImage imageNamed:@"markMan"]];
    
    [self.view addSubview:self.snapShotBackView];
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_8_0
    self.blutView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
    self.blutView.frame = [UIApplication sharedApplication].keyWindow.bounds;
    self.blutView.alpha = 0.80;
    [self.snapShotBackView addSubview:self.blutView];
#endif
    [self.view sendSubviewToBack:self.snapShotBackView];
    
    [self.view addSubview:self.itemView];
    
     
}


#pragma mark - itemView delegate

- (void)dissMiss {
    [UIView animateWithDuration:0.1 animations:^{
        self.snapShotBackView.alpha = 0;
    } completion:^(BOOL finished) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
