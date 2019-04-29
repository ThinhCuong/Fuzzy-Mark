//
//  FMMiddleButton.m
//  FuzzyMark
//
//  Created by Tu Tran on 4/14/19.
//  Copyright © 2019 Tu Tran. All rights reserved.
//

#import "FMMiddleButton.h"

@implementation FMMiddleButton

- (void)setImage:(UIImage *)image forState:(UIControlState)state {
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [super setImage:image forState:state];
    [self unselectedButton];
}

#pragma mark - public
- (void)selectedButton {
    [self setTintColor:[UIColor colorWithRed:0.2 green:0.6 blue:0.86 alpha:1.0]];
}

- (void)unselectedButton {
    [self setTintColor:UIColor.blackColor];
}

@end
