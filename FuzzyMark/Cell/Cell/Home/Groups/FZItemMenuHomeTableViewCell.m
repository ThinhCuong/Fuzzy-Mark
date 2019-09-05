//
//  FZItemMenuHomeTableViewCell.m
//  FuzzyMark
//
//  Created by Nguyen Cuong on 4/15/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import "FZItemMenuHomeTableViewCell.h"
#import "FZMenuHomeCollectionViewCell.h"
#import "FZItemMenuVerticalTableViewCell.h"

@interface FZItemMenuHomeTableViewCell() <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UITableViewDataSource, UITableViewDelegate> {
    NSArray<RewardObject *> *_listVoucherVertical;
    NSArray<RewardObject *> *_listVoucherHorizontal;
    GroupInfoObject * _groupInfoObject;
}

@property (strong, nonatomic) IBOutlet UICollectionView *menuCollectionView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *heightOfColectionView;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *heightOfTableView;

@end

@implementation FZItemMenuHomeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.menuCollectionView registerNib:[UINib nibWithNibName:@"FZMenuHomeCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"FZMenuHomeCollectionViewCell"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"FZItemMenuVerticalTableViewCell" bundle:nil] forCellReuseIdentifier:@"FZItemMenuVerticalTableViewCell"];
    
    self.menuCollectionView.dataSource = self;
    self.menuCollectionView.delegate = self;
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
}

- (void)bindData:(GroupInfoObject *) groupInfoObject {
    _listVoucherVertical = groupInfoObject.vouchersVertical;
    _listVoucherHorizontal = groupInfoObject.vouchersHorizontal;
    _groupInfoObject = groupInfoObject;
    _heightOfTableView.constant = 95 * _listVoucherVertical.count;
    [self.menuCollectionView reloadData];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _listVoucherHorizontal.count;
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    FZMenuHomeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FZMenuHomeCollectionViewCell" forIndexPath:indexPath];
    [cell bindData:_listVoucherHorizontal[indexPath.row]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    [self didSelectChooseItemWithVoucher:_listVoucherHorizontal[indexPath.row].rewardId];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGSize cellSize = CGSizeMake((collectionView.bounds.size.width - 32) * 216 / 360, 191);
    return cellSize;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _listVoucherVertical.count;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    FZItemMenuVerticalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FZItemMenuVerticalTableViewCell"];
    [cell bindData:_listVoucherVertical[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self didSelectChooseItemWithVoucher:_listVoucherVertical[indexPath.row].rewardId];
}

- (void)didSelectChooseItemWithVoucher:(NSInteger)voucherID {
    [self.delegate didSelectChooseItemWithIDVoucher:voucherID];
}

- (IBAction)showAllVoucher:(id)sender {
    if ([self.delegate respondsToSelector:@selector(didSelectSearchCategoryID:)]) {
        [self.delegate didSelectSearchCategoryID:_groupInfoObject.groupId];
    }
}

@end
