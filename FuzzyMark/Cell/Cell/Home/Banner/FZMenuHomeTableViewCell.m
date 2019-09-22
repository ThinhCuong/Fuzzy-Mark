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

@interface FZMenuHomeTableViewCell() <FSPagerViewDataSource, FSPagerViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet FSPagerView *bannerView;
@property (weak, nonatomic) IBOutlet FSPageControl *pageControl;
@property (weak, nonatomic) IBOutlet FSPagerView *fixedView;
@property (weak, nonatomic) IBOutlet UICollectionView *categoryCollectionView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintHeightCollectionView;

@end

@implementation FZMenuHomeTableViewCell {
    NSArray<BannerObject *> *_listBanner;
    NSArray<FixedAdsObject *> *_listFixed;
    NSArray<IConObject *> *_lisIcon;
    NSArray<IConObject *> *_lisIconFix;
}

#pragma mark - life cycle
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self initUI];
    [self initData];
}

#pragma mark - private
- (void)initUI {
    [self setBannerView];
    [self setFixedView];
    [self setCollectionView];
}

- (void)setBannerView {
    _bannerView.itemSize = FSPagerViewAutomaticSize;
    _bannerView.automaticSlidingInterval = 4;
    _bannerView.isInfinite = YES;
    [_bannerView registerClass:[FSPagerViewCell class] forCellWithReuseIdentifier:@"cell"];
    
    _pageControl.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
}

- (void)setFixedView {
    _fixedView.itemSize = FSPagerViewAutomaticSize;
    _fixedView.layer.cornerRadius = 5;
    _fixedView.clipsToBounds = YES;
    _fixedView.automaticSlidingInterval = 3;
    _fixedView.isInfinite = YES;
    _fixedView.transformer = [[FSPagerViewTransformer alloc] initWithType:FSPagerViewTransformerTypeCrossFading];
    [_fixedView registerClass:[FSPagerViewCell class] forCellWithReuseIdentifier:@"cell"];
}

- (void)setCollectionView {
    [_categoryCollectionView registerNib:[UINib nibWithNibName:@"FMMenuHomeCategoryCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
}

- (void)initData {
    IConObject *iconNew = [[IConObject alloc] init];
    iconNew.image = @"icon_home_news";
    iconNew.title = @"Tin tức";
    iconNew.adId =  CategoryNew;
    
    IConObject *iconMap = [[IConObject alloc] init];
    iconMap.image = @"icon_home_map";
    iconMap.title = @"Bản đồ";
    iconMap.adId = CategoryMap;
    
    NSMutableArray *listIcon = [NSMutableArray arrayWithObjects:iconNew, iconMap, nil];
    _lisIconFix = listIcon.copy;
}

#pragma mark - public
- (void)bindData:(FZHomeObject *)homeData {
    
    _listBanner = homeData.banners.copy;
    _listFixed = homeData.fixedAds.copy;
    
    NSMutableArray *arr = [NSMutableArray new];
    [arr addObjectsFromArray:homeData.iconGroups];
    [arr addObjectsFromArray:_lisIconFix];
    _lisIcon = arr.copy;
    
    _pageControl.numberOfPages = _listBanner.count;
    _pageControl.currentPage = 0;
    
    if (_lisIcon.count > 3) {
        self.constraintHeightCollectionView.constant = 148;
    } else {
        self.constraintHeightCollectionView.constant = 74;
    }
    
    [_bannerView reloadData];
    [_fixedView reloadData];
    [_categoryCollectionView reloadData];
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
    [pagerView deselectItemAtIndex:index animated:YES];
    [pagerView scrollToItemAtIndex:index animated:YES];
    if ([pagerView isEqual:_bannerView]) {
        BannerObject *obj;
        obj = _listBanner[index];
        if (obj.bannerType == 0) {
            if ([self.delegate respondsToSelector:@selector(didSelectVoucherID:)]) {
                [self.delegate didSelectVoucherID:obj.voucherId];
            }
        } else {
            if ([self.delegate respondsToSelector:@selector(didSelectWebviewWithLink:andTitle:)]) {
                [self.delegate didSelectWebviewWithLink:obj.urlAds andTitle:@""];
            }
        }
    } else {
        FixedAdsObject *obj = _listFixed[index];
        if (obj.adType == 0) {
            if ([self.delegate respondsToSelector:@selector(didSelectVoucherID:)]) {
                [self.delegate didSelectVoucherID:obj.voucherId];
            }
        } else {
            if ([self.delegate respondsToSelector:@selector(didSelectWebviewWithLink:andTitle:)]) {
                [self.delegate didSelectWebviewWithLink:obj.urlAds andTitle:@""];
            }
        }
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

#pragma mark = UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _lisIcon.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FMMenuHomeCategoryCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    [cell binDataWithIconGroup:_lisIcon[indexPath.row]];
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat value = [UIScreen mainScreen].bounds.size.width/3;
    return CGSizeMake(value, 74);
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    IConObject *icon = _lisIcon[indexPath.row];
    if (icon.adId == CategoryNew) {
        if ([self.delegate respondsToSelector:@selector(didSelectSearchCategoryNew)]) {
            [self.delegate didSelectSearchCategoryNew];
        }
    } else if (icon.adId == CategoryMap) {
        if ([self.delegate respondsToSelector:@selector(didSelectSearchCategoryMap)]) {
            [self.delegate didSelectSearchCategoryMap];
        }
    } else {
        if ([self.delegate respondsToSelector:@selector(didSelectSearchCategoryID:placeholder:)]) {
            [self.delegate didSelectSearchCategoryID:icon.adId placeholder:icon.title];
        }
    }
}

- (IBAction)didSelectListSuport:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(didSelectSuportList:)]) {
        [self.delegate didSelectSuportList:sender.tag];
    }
}

@end
