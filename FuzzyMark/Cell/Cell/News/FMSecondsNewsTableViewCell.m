//
//  FMSecondsNewsTableViewCell.m
//  FuzzyMark
//
//  Created by Tu Tran on 4/17/19.
//  Copyright © 2019 Tu Tran. All rights reserved.
//

#import "FMSecondsNewsTableViewCell.h"

@implementation FMSecondsNewsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [CommonFunction setCornerRadiusUIImageView:self.newsImage cornerRadiusValue:5];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)bindData:(FZNewsObject *)newsInfo {
    [self.newsImage sd_setImageWithURL: [NSURL URLWithString:newsInfo.image]];
    self.titleLabel.text = newsInfo.title;
    self.timeLabel.text = newsInfo.time;
}

@end
