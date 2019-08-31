//
//  FMPageInfoRateCell.m
//  FuzzyMark
//
//  Created by Tu Tran on 8/30/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import "FMPageInfoRateCell.h"

@implementation FMPageInfoRateCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.imgUser.layer.cornerRadius = self.imgUser.layer.frame.size.height/2;
}

- (void)binDataWith:(RageView *) pageInfo {
    [self.imgUser sd_setImageWithURL:[NSURL URLWithString:pageInfo.user.avatar] placeholderImage:kUserPlaceholderImage];
    self.lbName.text = pageInfo.user.name?:@"";
    self.lbTime.text = pageInfo.time?:@"";
    self.rateView.rating = pageInfo.point;
}

@end
