//
//  FMButtonNext.m
//  FuzzyMark
//
//  Created by Tu Tran on 5/28/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import "FMButtonNext.h"

@implementation FMButtonNext

- (void)awakeFromNib {
    [super awakeFromNib];
    // Set shadow button Save
    self.layer.cornerRadius = 10;
    self.clipsToBounds = YES;
    self.layer.masksToBounds = NO;
    self.layer.shadowOffset = CGSizeMake(0, 5);
    self.layer.shadowColor = [UIColor colorWithRed:0.31 green:0.72 blue:1.0 alpha:0.3].CGColor;
    self.layer.shadowRadius = 5;
    self.layer.shadowOpacity = 1.0;
}

@end
