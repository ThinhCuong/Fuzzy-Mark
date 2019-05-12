//
//  FZBannerCollectionViewCell.m
//  FuzzyMark
//
//  Created by Nguyen Cuong on 5/12/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import "FZBannerCollectionViewCell.h"

@implementation FZBannerCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)bindData:(FZBannerModel *)bannerInfo {
    [self.bannerImage sd_setImageWithURL:[NSURL URLWithString:bannerInfo.image]];
}

@end
