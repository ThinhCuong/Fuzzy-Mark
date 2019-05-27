//
//  UITabBar+MiddleButton.m
//  FuzzyMark
//
//  Created by Tu Tran on 5/27/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import "UITabBar+FMMiddleButton.h"
#import <objc/runtime.h>

@implementation UITabBar (FMMiddleButton)

- (void)setMiddleButton:(FMMiddleButton *)middleButton {
    objc_setAssociatedObject(self, @selector(middleButton), middleButton, OBJC_ASSOCIATION_RETAIN);
}

- (FMMiddleButton *)middleButton {
    return objc_getAssociatedObject(self, @selector(middleButton));
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    if(CGRectContainsPoint(self.middleButton.frame, point)) {
        return self.middleButton;
    }
    return [super hitTest:point withEvent:event];
}

@end
