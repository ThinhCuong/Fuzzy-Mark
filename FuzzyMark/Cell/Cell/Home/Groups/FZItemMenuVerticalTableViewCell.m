//
//  FZItemMenuVerticalTableViewCell.m
//  FuzzyMark
//
//  Created by Nguyen Cuong on 5/5/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import "FZItemMenuVerticalTableViewCell.h"

@implementation FZItemMenuVerticalTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.image.layer.cornerRadius = 72/2;
    self.image.clipsToBounds = YES;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)bindData:(RewardObject *)groupInfo {
    [self.image sd_setImageWithURL:[NSURL URLWithString:groupInfo.image]];
    self.nameLabel.text = groupInfo.name;
    self.groupInfoDescriptionLabel.text = groupInfo.rewardDescription;
    self.percenDiscountLabel.text = [NSString stringWithFormat:@"Hoàn tiền %ld %@", (long)groupInfo.percentDiscount, @"%"];
}

@end
