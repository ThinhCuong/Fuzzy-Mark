//
//  FZItemSearchCollectionViewCell.m
//  FuzzyMark
//
//  Created by Nguyen Cuong on 5/28/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import "FZItemSearchCollectionViewCell.h"
#import "CommonFunction.h"

@implementation FZItemSearchCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [CommonFunction setCornerRadiusUIImageView:self.image cornerRadiusValue:15];
}

- (void)bindData:(CategoryObject *)category {
    [self.image sd_setImageWithURL:[NSURL URLWithString:category.image]];
    self.titleLabel.text = category.name;
}

@end
