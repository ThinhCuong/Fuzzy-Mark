//
//  FMStackViewShadow.m
//  FuzzyMark
//
//  Created by Tu Tran on 4/14/19.
//  Copyright © 2019 Tu Tran. All rights reserved.
//

#import "FMStackViewShadow.h"

@implementation FMStackViewShadow

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    self.layer.shadowRadius = 14.0;
    self.layer.shadowColor = [UIColor colorWithRed:0.2 green:0.6 blue:0.86 alpha:0.22].CGColor;
    self.layer.shadowOffset = CGSizeMake(0, 4);
    self.layer.masksToBounds = NO;
    
    UIEdgeInsets shadowInsets = UIEdgeInsetsMake(0, 0, -1.5f, 0);
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:UIEdgeInsetsInsetRect(self.bounds, shadowInsets)];
    self.layer.shadowPath = shadowPath.CGPath;
}


@end
