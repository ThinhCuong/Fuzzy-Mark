//
//  FMAllRateCell.m
//  FuzzyMark
//
//  Created by Tu Tran on 9/24/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import "FMAllRateCell.h"

@implementation FMAllRateCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)binData:(RageView *) model {
    NSURL *url = [NSURL URLWithString:model.user.avatar];
    [self.imgAvatar sd_setImageWithURL:url placeholderImage:kUserPlaceholderImage];
    self.lbName.text = model.user.name?:@"";
    self.lbTime.text = model.time?:@"";
    self.lbComment.text = model.comment?:@"";
}

@end
