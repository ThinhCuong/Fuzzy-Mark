//
//  FZMenuHomeTableViewCell.m
//  FuzzyMark
//
//  Created by Nguyen Cuong on 4/15/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import "FZMenuHomeTableViewCell.h"

@interface FZMenuHomeTableViewCell()

@property (strong, nonatomic) IBOutlet UICollectionView *bannerCollectionView;

@end

@implementation FZMenuHomeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
