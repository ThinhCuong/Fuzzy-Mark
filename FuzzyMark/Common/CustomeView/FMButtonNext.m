//
//  FMButtonNext.m
//  FuzzyMark
//
//  Created by Tu Tran on 5/28/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import "FMButtonNext.h"
#import "UIImage+Support.h"

@implementation FMButtonNext

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setLayerButton];
    [self setTitleButton];
}

- (void)setLayerButton {
    // Set shadow button Save
    self.layer.cornerRadius = 10;
    self.clipsToBounds = YES;
    self.layer.masksToBounds = NO;
    self.layer.shadowOffset = CGSizeMake(0, 5);
    self.layer.shadowRadius = 5;
    self.layer.shadowOpacity = 1.0;
    [self changeButtonWithEnable:self.isEnabled];
}

- (void)setTitleButton {
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.titleLabel.font = [UIFont setBoldFontMuliWithSize:14.0];
}

- (void)setEnabled:(BOOL)enabled {
    [super setEnabled:enabled];
    [self changeButtonWithEnable:enabled];
}

- (void)changeButtonWithEnable:(BOOL) enabled {
    if (enabled) {
        self.layer.shadowColor = [UIColor colorWithRed:0.31 green:0.72 blue:1.0 alpha:0.3].CGColor;
        self.backgroundColor = [UIColor colorWithRed:0.2 green:0.6 blue:0.86 alpha:1.0];
    } else {
        self.layer.shadowColor = [UIColor lightGrayColor].CGColor;
        self.backgroundColor = UIColor.lightGrayColor;
    }
}

@end
