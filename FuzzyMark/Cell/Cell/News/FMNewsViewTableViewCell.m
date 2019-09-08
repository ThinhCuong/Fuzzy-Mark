//
//  FMNewsViewTableViewCell.m
//  FuzzyMark
//
//  Created by Tu Tran on 9/7/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import "FMNewsViewTableViewCell.h"
#import "FMNewsCollectionViewCell.h"

@implementation FMNewsViewTableViewCell {
    NSArray *_listNewsRelate;
}

- (void)binDataWithListNewRelate:(NSArray *) array {
    _listNewsRelate = array.copy;
    [self.collectionView reloadData];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.collectionView registerNib:[UINib nibWithNibName:@"FMNewsCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"FMNewsCollectionViewCell"];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
}

#pragma mark - UICollectionViewDatasource
- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _listNewsRelate.count;
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    FMNewsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FMNewsCollectionViewCell" forIndexPath:indexPath];
    [cell bindData:_listNewsRelate[indexPath.row]];
    return cell;
}

@end
