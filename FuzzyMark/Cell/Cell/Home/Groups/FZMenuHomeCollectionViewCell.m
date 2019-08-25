//
//  FZMenuHomeCollectionViewCell.m
//  FuzzyMark
//
//  Created by Nguyen Cuong on 4/18/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import "FZMenuHomeCollectionViewCell.h"
#import "CommonFunction.h"

@implementation FZMenuHomeCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [CommonFunction setCornerRadiusUIImageView:self.groupImage cornerRadiusValue:5];
}

- (void)bindData:(RewardObject *)groupInfo {
    [self.groupImage sd_setImageWithURL:[NSURL URLWithString:groupInfo.image]];
    self.nameLabel.text = groupInfo.name;
    self.groupInfoDescriptionLabel.text = groupInfo.page.address;
    self.percenDiscountLabel.text = [NSString stringWithFormat:@"Hoàn tiền %ld %@", (long)groupInfo.percentDiscount, @"%"];
}

@end
