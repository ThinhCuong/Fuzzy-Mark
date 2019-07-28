//
//  CommonFunction.m
//  FuzzyMark
//
//  Created by Tu Tran on 4/14/19.
//  Copyright © 2019 Tu Tran. All rights reserved.
//

#import "CommonFunction.h"
#import "AppDelegate.h"

@implementation CommonFunction

+ (void)setCornerRadiusUIImageView:(UIImageView *)imageView cornerRadiusValue:(float )cornerRadiusValue {
    imageView.layer.cornerRadius = cornerRadiusValue;
    imageView.clipsToBounds = YES;
}

+ (void)showLoadingView {
    [self showLoadingViewInView:appDelegate.window.rootViewController.view];
}

+ (void)showLoadingViewInView:(UIView *) view {
    [SVProgressHUD setContainerView:view];
    [SVProgressHUD show];
}

+ (void)hideLoadingView {
    [SVProgressHUD dismiss];
}

+ (void)showToast:(NSString *) toast {
    [self showToast:toast inView:appDelegate.window.rootViewController.view];
}

+ (void)showToast:(NSString *) toast inView:(UIView *) view {
    if (toast.length == 0) {
        return;
    }
    [SVProgressHUD showWithStatus:toast];
}

@end

@implementation UIFont (CustomFont)
+ (UIFont*)setFontLightMuliWithSize:(CGFloat)fontSize {
    return [UIFont fontWithName:@"Muli" size:fontSize];
}

+ (UIFont*)setFontMuliWithSize:(CGFloat)fontSize {
    return [UIFont fontWithName:@"Muli-Regular" size:fontSize];
}

+ (UIFont*)setMediumFontMuliWithSize:(CGFloat)fontSize {
    return [UIFont fontWithName:@"Muli-Medium" size:fontSize];
}

+ (UIFont *)setBoldFontMuliWithSize:(CGFloat)fontSize {
    return [UIFont fontWithName:@"Muli-Bold" size:fontSize];
}

+ (UIFont *)setItalicFontMuliWithSize:(CGFloat)fontSize {
    return [UIFont fontWithName:@"Muli-Italic" size:fontSize];
}

+ (UIFont *)setBoldItalicFontMuliWithSize:(CGFloat)fontSize {
    return [UIFont fontWithName:@"Muli-BoldItalic" size:fontSize];
}

+ (UIFont *)setLightItalicFontMuliWithSize:(CGFloat)fontSize {
    return [UIFont fontWithName:@"Muli-LightItalic" size:fontSize];
}

@end

