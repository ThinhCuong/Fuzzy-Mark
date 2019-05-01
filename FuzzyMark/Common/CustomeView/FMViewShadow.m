//
//  FMStackViewShadow.m
//  FuzzyMark
//
//  Created by Tu Tran on 4/14/19.
//  Copyright © 2019 Tu Tran. All rights reserved.
//

#import "FMViewShadow.h"

@implementation FMViewShadow

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if(self) {
        self.layer.cornerRadius = 5;
        self.layer.shadowRadius = 14.0;
        self.layer.shadowOpacity = 1.0;
        self.layer.shadowColor = [UIColor colorWithRed:0.2 green:0.6 blue:0.86 alpha:0.22].CGColor;
        self.layer.shadowOffset = CGSizeMake(0, 4);
        self.layer.masksToBounds = NO;
        
        UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:5];
        self.layer.shadowPath = shadowPath.CGPath;
    }
    return self;
}


@end
