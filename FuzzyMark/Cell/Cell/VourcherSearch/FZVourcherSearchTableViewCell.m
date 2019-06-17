//
//  FZVourcherSearchTableViewCell.m
//  FuzzyMark
//
//  Created by Nguyen Cuong on 6/14/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import "FZVourcherSearchTableViewCell.h"
#import "CommonFunction.h"

@implementation FZVourcherSearchTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [CommonFunction setCornerRadiusUIImageView:self.image cornerRadiusValue:45];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)bindData:(FZGroupInfoJsonModel *)groupInfo {
    [self.image sd_setImageWithURL: [NSURL URLWithString:groupInfo.image]];
    self.nameLabel.text = groupInfo.name;
    self.discountLabel.text = [NSString stringWithFormat:@"Hoàn tiền %ld%@", groupInfo.percent_discount, @"%"];
    self.addressLabel.text = groupInfo.page.address;
    self.totalRateLabel.text = [NSString stringWithFormat:@"%ld", groupInfo.page.total_rate];
    self.totalRateCountLabel.text = [NSString stringWithFormat:@"(%ld)", groupInfo.page.rate_count];
}

@end
