//
//  FMRateCommentCell.m
//  FuzzyMark
//
//  Created by Tu Tran on 9/8/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import "FMRateCommentCell.h"

@implementation FMRateCommentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.boxView.layer.cornerRadius = 5;
    self.boxView.layer.borderColor = [UIColor colorWithRed:0.59 green:0.59 blue:0.59 alpha:1.0].CGColor;
    self.boxView.layer.borderWidth = 0.5;
}

- (void)binData:(NSString *) text  {
    self.lbTitle.text = text;
}

@end
