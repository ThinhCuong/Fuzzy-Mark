//
//  CommonFunction.h
//  FuzzyMark
//
//  Created by Tu Tran on 4/14/19.
//  Copyright © 2019 Tu Tran. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CommonFunction : NSObject
// set corner radius image view
+ (void)setCornerRadiusUIImageView:(UIImageView *)imageView cornerRadiusValue:(float )cornerRadiusValue;
+ (void)showLoadingView;
+ (void)showLoadingViewInView:(UIView *) view;
+ (void)hideLoadingView;
+ (void)showToast:(NSString *) toast;
+ (void)showToast:(NSString *) toast inView:(UIView *) view;
+ (void)configServer;
+ (NSAttributedString *)convertHTMLString:(NSString *) stringHTML;

@end

@interface UIFont (CustomFont)
+ (UIFont*)setFontLightMuliWithSize:(CGFloat)fontSize;
+ (UIFont*)setFontMuliWithSize:(CGFloat)fontSize;
+ (UIFont*)setMediumFontMuliWithSize:(CGFloat)fontSize;
+ (UIFont *)setBoldFontMuliWithSize:(CGFloat)fontSize;
+ (UIFont *)setItalicFontMuliWithSize:(CGFloat)fontSize;
+ (UIFont *)setBoldItalicFontMuliWithSize:(CGFloat)fontSize;
+ (UIFont *)setLightItalicFontMuliWithSize:(CGFloat)fontSize;

@end

NS_ASSUME_NONNULL_END
