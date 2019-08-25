//
//  FMNewsCollectionViewCell.m
//  FuzzyMark
//
//  Created by Tu Tran on 4/17/19.
//  Copyright © 2019 Tu Tran. All rights reserved.
//

#import "FMNewsCollectionViewCell.h"

@implementation FMNewsCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [CommonFunction setCornerRadiusUIImageView:self.newsImage cornerRadiusValue:5];
}

@end
