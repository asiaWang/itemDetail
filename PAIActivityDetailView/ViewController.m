//
//  ViewController.m
//  PAIActivityDetailView
//
//  Created by bo on 15/11/23.
//  Copyright © 2015年 com.pencho.com. All rights reserved.
//

#import "ViewController.h"
#import "PAIActivitySingleDetailViewViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)presentDetailView:(id)sender {
    
    UIView *snapShotView = [self.view snapshotViewAfterScreenUpdates:YES];
    
    
    PAIActivitySingleDetailViewViewController *activityDetailViewController = [[PAIActivitySingleDetailViewViewController alloc] init];
//    [activityDetailViewController setSourceSnapShotImage:[self imageFromView:snapShotView]];
    [self presentViewController:activityDetailViewController animated:YES completion:nil];
    
}

- (UIImage *)imageFromView:(UIView *)sourceView {
    UIGraphicsBeginImageContextWithOptions(sourceView.bounds.size, YES, sourceView.layer.contentsScale);
    [sourceView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image?image:nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
