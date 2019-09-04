//
//  FZMenuHomeTableViewCell.m
//  FuzzyMark
//
//  Created by Nguyen Cuong on 4/15/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import "FZMenuHomeTableViewCell.h"
#import "FuzzyMark-Swift.h"
#import <FSPagerView-Swift.h>
#import "FSPagerViewObjcCompat.h"
#import "FMMenuHomeCategoryCell.h"

@interface FZMenuHomeTableViewCell() <FSPagerViewDataSource, FSPagerViewDelegate>

@property (weak, nonatomic) IBOutlet FSPagerView *bannerView;
@property (weak, nonatomic) IBOutlet FSPageControl *pageControl;
@property (weak, nonatomic) IBOutlet FSPagerView *fixedView;
@property (weak, nonatomic) IBOutlet UICollectionView *categoryCollectionView;

@end

@implementation FZMenuHomeTableViewCell {
    NSArray<BannerObject *> *_listBanner;
    NSArray<FixedAdsObject *> *_listFixed;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self initUI];
    [self initData];
}

- (void)initUI {
    
}

- (void)initData {
    [self setDataBannerView];
    [self setDataFixedView];
    [self setDataCollectionView];
}

- (void)setDataBannerView {
    _bannerView.itemSize = FSPagerViewAutomaticSize;
    _bannerView.automaticSlidingInterval = 4;
    _bannerView.isInfinite = YES;
    [_bannerView registerClass:[FSPagerViewCell class] forCellWithReuseIdentifier:@"cell"];
    
    _pageControl.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
}

- (void)setDataFixedView {
    _fixedView.itemSize = FSPagerViewAutomaticSize;
    _fixedView.layer.cornerRadius = 5;
    _fixedView.clipsToBounds = YES;
    _fixedView.automaticSlidingInterval = 3;
    _fixedView.isInfinite = YES;
    _fixedView.transformer = [[FSPagerViewTransformer alloc] initWithType:FSPagerViewTransformerTypeCrossFading];
    [_fixedView registerClass:[FSPagerViewCell class] forCellWithReuseIdentifier:@"cell"];
}

- (void)setDataCollectionView {
    [_categoryCollectionView registerNib:[UINib nibWithNibName:@"FMMenuHomeCategoryCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
}

- (void)bindData:(FZHomeObject *)homeData {
    _listBanner = homeData.banners;
    _listFixed = homeData.fixedAds;
    _pageControl.numberOfPages = _listBanner.count;
    _pageControl.currentPage = 0;
    [_bannerView reloadData];
    [_fixedView reloadData];
}

#pragma mark - FSPagerViewDataSource
- (NSInteger)numberOfItemsInPagerView:(FSPagerView *)pagerView {
    if ([pagerView isEqual:_bannerView]) {
        return _listBanner.count;
    } else {
        return _listFixed.count;
    }
}

- (FSPagerViewCell *)pagerView:(FSPagerView *)pagerView cellForItemAtIndex:(NSInteger)index {
    FSPagerViewCell *cell = [pagerView dequeueReusableCellWithReuseIdentifier:@"cell" atIndex:index];
    cell.imageView.contentMode = UIViewContentModeScaleAspectFill;
    if ([pagerView isEqual:_bannerView]) {
        BannerObject *obj = _listBanner[index];
        [cell.imageView sd_setImageWithURL:[NSURL URLWithString:obj.image]];
    } else {
        FixedAdsObject *obj = _listFixed[index];
        [cell.imageView sd_setImageWithURL:[NSURL URLWithString:obj.imageAds]];
    }
    return cell;
}

#pragma mark - FSPagerView Delegate
- (void)pagerView:(FSPagerView *)pagerView didSelectItemAtIndex:(NSInteger)index {
    if ([pagerView isEqual:_bannerView]) {
        [pagerView deselectItemAtIndex:index animated:YES];
        [pagerView scrollToItemAtIndex:index animated:YES];
    }
}

- (void)pagerViewWillEndDragging:(FSPagerView *)pagerView targetIndex:(NSInteger)targetIndex {
    if ([pagerView isEqual:_bannerView]) {
        self.pageControl.currentPage = targetIndex;
    }
}

- (void)pagerViewDidEndScrollAnimation:(FSPagerView *)pagerView {
    if ([pagerView isEqual:_bannerView]) {
        self.pageControl.currentPage = pagerView.currentIndex;
    }
}

@end
