//
//  FMFirstNewsTableViewCell.m
//  FuzzyMark
//
//  Created by Tu Tran on 4/17/19.
//  Copyright © 2019 Tu Tran. All rights reserved.
//

#import "FMFirstNewsTableViewCell.h"


@implementation FMFirstNewsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [CommonFunction setCornerRadiusUIImageView:self.image cornerRadiusValue:10];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (void)bindData:(FZNewsObject *)newsInfo {
    [self.image sd_setImageWithURL: [NSURL URLWithString:newsInfo.image]];
    self.descriptionLabel.text = newsInfo.title;
    self.timeLabel.text = newsInfo.time;
}
@end
