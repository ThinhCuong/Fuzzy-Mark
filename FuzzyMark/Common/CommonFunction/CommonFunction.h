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
