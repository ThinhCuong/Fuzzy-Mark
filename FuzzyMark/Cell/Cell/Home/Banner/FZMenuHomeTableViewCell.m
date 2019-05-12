//
//  FZMenuHomeTableViewCell.m
//  FuzzyMark
//
//  Created by Nguyen Cuong on 4/15/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import "FZMenuHomeTableViewCell.h"
#import "FZBannerCollectionViewCell.h"

@interface FZMenuHomeTableViewCell() <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout> {
    NSArray<FZBannerModel> *_listBanner;
    
}

@property (strong, nonatomic) IBOutlet UICollectionView *bannerCollectionView;
@property (nonatomic, weak) NSTimer *timer;
@property (strong, nonatomic) IBOutlet UIPageControl *pageControl;

@end

@implementation FZMenuHomeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.bannerCollectionView registerNib:[UINib nibWithNibName:@"FZBannerCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"FZBannerCollectionViewCell"];
    
    self.bannerCollectionView.dataSource = self;
    self.bannerCollectionView.delegate = self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)bindData:(NSArray<FZBannerModel> *) listBanner {
    _listBanner = listBanner;
    [self.bannerCollectionView reloadData];
    [self stopTimer];
    [self startTimer];
}
- (void)stopTimer {
    [self.timer invalidate];
    self.timer = nil;
}

- (void)startTimer {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(nextImage) userInfo:nil repeats:YES];
}

- (void)nextImage {
    CGPoint offset = CGPointMake(self.bannerCollectionView.contentOffset.x + self.bannerCollectionView.bounds.size.width, self.bannerCollectionView.contentOffset.y);
    [self.bannerCollectionView setContentOffset:offset animated:YES];
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _listBanner.count ? 100000 : 0;
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    FZBannerCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FZBannerCollectionViewCell" forIndexPath:indexPath];
    [cell bindData:_listBanner[indexPath.row % _listBanner.count]];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGSize cellSize = CGSizeMake(collectionView.bounds.size.width, collectionView.bounds.size.height);
    return cellSize;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self scrollViewDidEndScrollingAnimation:scrollView];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    CGFloat currentContentOffset = scrollView.contentOffset.x;
    CGFloat widthCell = self.bannerCollectionView.bounds.size.width;
    int pageIndexTemp = currentContentOffset/widthCell;
    if (_listBanner.count > 0) {
        [self.pageControl setCurrentPage:pageIndexTemp % _listBanner.count];
    }
}

@end
