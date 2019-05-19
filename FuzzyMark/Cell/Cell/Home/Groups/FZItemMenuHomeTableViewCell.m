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
    NSArray<FZGroupInfoJsonModel> *_listVoucherVertical;
    NSArray<FZGroupInfoJsonModel> *_listVoucherHorizontal;
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

- (void)bindData:(NSArray<FZGroupInfoJsonModel> *)listVoucherVertical listVoucherHorizontal:(NSArray<FZGroupInfoJsonModel> *)listVoucherHorizontal {
    _listVoucherVertical = listVoucherVertical;
    _listVoucherHorizontal = listVoucherHorizontal;
    _heightOfTableView.constant = 95 * listVoucherVertical.count;
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

@end
