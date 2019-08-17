//
//  FZHeaderSearchTableViewCell.m
//  FuzzyMark
//
//  Created by Nguyen Cuong on 5/30/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import "FZHeaderSearchTableViewCell.h"
#import "FZHeaderItemCollectionViewCell.h"

@interface FZHeaderSearchTableViewCell() <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout> {
    NSArray<Group *> *_listGroup;
}

@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation FZHeaderSearchTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.collectionView registerNib:[UINib nibWithNibName:@"FZHeaderItemCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"FZHeaderItemCollectionViewCell"];
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.sectionIndex = 0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)bindData:(NSArray *)listGroup {
    _listGroup = listGroup;
    [self.collectionView reloadData];
}
- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _listGroup.count;
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    FZHeaderItemCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FZHeaderItemCollectionViewCell" forIndexPath:indexPath];
    [cell bindData:_listGroup[indexPath.row]];
    cell.backgroundIcon.backgroundColor = self.sectionIndex == indexPath.row ? [UIColor colorWithRed:204.0f/255.0f green:233.0f/255.0f blue:255.0f/255.0f alpha:1] : UIColor.whiteColor;
    cell.selectedLineView.backgroundColor = self.sectionIndex == indexPath.row ? [UIColor colorWithRed:43.0f/255.0f green:132.0f/255.0f blue:210.0f/255.0f alpha:1] : UIColor.whiteColor;
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGSize cellSize = CGSizeMake(48, 50);
    return cellSize;
}

@end
