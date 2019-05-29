//
//  FZHeaderItemCollectionViewCell.m
//  FuzzyMark
//
//  Created by Nguyen Cuong on 5/29/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import "FZHeaderItemCollectionViewCell.h"

@implementation FZHeaderItemCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)bindData:(GroupObject *)groupInfo {
    [self.iconImage sd_setImageWithURL:[NSURL URLWithString:groupInfo.icon]];
}

@end
