//
//  PAIActiviryItemView.m
//  PAIActivityDetailView
//
//  Created by bo on 15/11/23.
//  Copyright © 2015年 com.pencho.com. All rights reserved.
//

#import "PAIActiviryItemView.h"
#import "PAIActivityItemDetailView.h"
#import "PAIActivityItemGroupView.h"


static CGFloat ItmeDetailHeight = 236.f;

@interface PAIActiviryItemView()<PAIActivityItemDetailViewDelegate>
@property (nonatomic,strong)PAIActivityItemDetailView *itemDetailView;
@property (nonatomic,strong)PAIActivityItemGroupView *itemGroupView;
@property (nonatomic,strong)NSMutableArray *itemsArray;
@end

@implementation PAIActiviryItemView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.65];
        [self initLeftNavigationBackButton];
    }
    return self;
}
// 单品详情大图
- (PAIActivityItemGroupView *)itemGroupView {
    if (!_itemGroupView) {
        _itemGroupView = [[[NSBundle mainBundle]loadNibNamed:@"PAIActivityItemGroupView" owner:nil options:nil]lastObject];
        
        CGFloat itemGroupSize = self.frame.size.width - 100;
        CGFloat itemGroupHeight = itemGroupSize + 37;
        CGFloat itemGroupCurrentHeight = self.frame.size.height - ItmeDetailHeight - 64;
        if (itemGroupCurrentHeight > itemGroupHeight) {
            _itemGroupView.frame = CGRectMake(self.frame.size.width / 2 - itemGroupSize / 2, 64 + (itemGroupCurrentHeight - itemGroupHeight) / 2, itemGroupSize, itemGroupHeight);
        }else {
            _itemGroupView.frame = CGRectMake(self.frame.size.width / 2 - 160, 64, 320, 320 + 37);
        }
        
        [self addSubview:_itemGroupView];
    }
    return _itemGroupView;
}

// 单品描述部分,包括单品的list
- (PAIActivityItemDetailView *)itemDetailView {
    if (!_itemDetailView) {
        _itemDetailView = [[[NSBundle mainBundle]loadNibNamed:@"PAIActivityItemDetailView" owner:nil options:nil]lastObject];
        _itemDetailView.frame = CGRectMake(0, self.frame.size.height - ItmeDetailHeight, self.frame.size.width, ItmeDetailHeight);
        _itemDetailView.delegate = self;
        __weak __typeof(self)weakSelf = self;
        _itemDetailView.clickToBuyBlock = ^ {
            if ([weakSelf.delegate respondsToSelector:@selector(clickToBuyWithItem:)]) {
                [weakSelf.delegate clickToBuyWithItem:weakSelf.itemDetailView.frontShowItem];
            }
        };
        _itemDetailView.linkToOfficialBlock = ^ {
            if ([weakSelf.delegate respondsToSelector:@selector(linkToOfficialWithItem:)]) {
                [weakSelf.delegate linkToOfficialWithItem:weakSelf.itemDetailView.frontShowItem];
            }
        };
        [self addSubview:_itemDetailView];
    }
    return _itemDetailView;
}

- (NSMutableArray *)itemsArray {
    if (!_itemsArray) {
        _itemsArray = [NSMutableArray array];
    }
    return _itemsArray;
}

- (void)initLeftNavigationBackButton {
    UIButton *leftBackButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBackButton.frame = CGRectMake(20, 20, 44, 44);
    [leftBackButton setTitle:@"back" forState:UIControlStateNormal];
    [leftBackButton addTarget:self action:@selector(clickToBack:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:leftBackButton];
}

- (void)setNeedsDisplayItems:(NSArray *)itemArray {
    if (itemArray.count > 0) {
        if (self.itemsArray.count > 0) {
            [self.itemsArray removeAllObjects];
        }
        [self.itemsArray addObjectsFromArray:itemArray];
        [self updateCurrentUI];
    }
}

- (void)updateCurrentUI {
    [self.itemGroupView setSourceData:@[@"6.jpg",@"7.jpg",@"8.jpg",@"9.jpg"]];
    [self.itemDetailView setItemsListSource:self.itemsArray];
}


#pragma mark - itemDetail delegate
- (void)scrollViewDidSelectedNewItem:(id)newItem {
    
    // 刷新itemGroup View
    if (newItem) {
        [self.itemGroupView setSourceData:@[@"6.jpg",@"7.jpg",@"8.jpg",@"9.jpg"]];
    }
}

#pragma barck - dimiss
- (void)clickToBack:(id)sender {
    if ([self.delegate respondsToSelector:@selector(dissMiss)]) {
        [self.delegate dissMiss];
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
