//
//  FZTitleHeaderCollectionReusableView.m
//  FuzzyMark
//
//  Created by Nguyen Cuong on 5/30/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import "FZTitleHeaderCollectionReusableView.h"

@implementation FZTitleHeaderCollectionReusableView

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)bindData:(NSString *)title {
    self.titleLabel.text = title.uppercaseString;
}

@end
