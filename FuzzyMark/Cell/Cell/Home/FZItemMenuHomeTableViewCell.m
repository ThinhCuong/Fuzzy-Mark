//
//  FZItemMenuHomeTableViewCell.m
//  FuzzyMark
//
//  Created by Nguyen Cuong on 4/15/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import "FZItemMenuHomeTableViewCell.h"
#import "FZMenuHomeCollectionViewCell.h"

@interface FZItemMenuHomeTableViewCell()
@property (strong, nonatomic) IBOutlet UICollectionView *menuCollectionView;
@property (strong, nonatomic) IBOutlet UICollectionView *itemMenuCollectionView;

@end

@implementation FZItemMenuHomeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.menuCollectionView registerNib:[UINib nibWithNibName:@"FZMenuHomeCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"FZMenuHomeCollectionViewCell"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
