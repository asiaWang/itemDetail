//
//  PAIActivityItemDetalView.m
//  PAIActivityDetailView
//
//  Created by bo on 15/11/23.
//  Copyright © 2015年 com.pencho.com. All rights reserved.
//

#import "PAIActivityItemDetailView.h"
#import "PAIActivityItemScrollView.h"

@interface PAIActivityItemDetailView()<PAIActivityItemScrollViewDelegate>

@property (nonatomic,strong,readwrite)id frontShowItem;
@property (weak, nonatomic) IBOutlet UILabel *itemLinkLabel;

@property (weak, nonatomic) IBOutlet UILabel *itemCategoryLabel;
@property (weak, nonatomic) IBOutlet UILabel *itemCurrentPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *itemOriginPriceLabel;
@property (weak, nonatomic) IBOutlet UIButton *itemBuyButton;
@property (weak, nonatomic) IBOutlet UIView *itemListView;

@property (nonatomic,strong)PAIActivityItemScrollView *itemScrollView;
@end
@implementation PAIActivityItemDetailView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.itemBuyButton.layer.cornerRadius = 20.f;
    [self.itemListView addSubview:self.itemScrollView];
}

- (PAIActivityItemScrollView *)itemScrollView {
    if (!_itemScrollView) {
        _itemScrollView = [[PAIActivityItemScrollView alloc] initWithFrame:self.frame];
        _itemScrollView.delegate = self;
    }
    return _itemScrollView;
}


#pragma mark - itemListScrollView delegate

- (void)scrollViewDidChangedFrontItem:(id)item {
    if (item) {
        self.frontShowItem = item;
    }
}

#pragma mark - buy link

- (IBAction)clickToBuy:(id)sender {
    self.clickToBuyBlock();
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
