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
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:10];
    CALayer *layer = [CALayer new];
    layer.shadowPath = shadowPath.CGPath;
    layer.shadowColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1].CGColor;
    layer.shadowOpacity = 1;
    layer.shadowRadius = 9;
    layer.shadowOffset = CGSizeMake(0, 4);
    layer.bounds = self.bounds;
    layer.position = self.center;
    [self.shadowView.layer addSublayer:layer];
    self.bgView.layer.cornerRadius = 10;
}

- (void)bindData:(FZNewsObject *)newsInfo {
    [self.newsImage sd_setImageWithURL: [NSURL URLWithString:newsInfo.image]];
    self.titleLabel.text = newsInfo.title;
}
@end
