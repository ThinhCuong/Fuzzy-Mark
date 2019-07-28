//
//  UIImage+Support.m
//  FuzzyMark
//
//  Created by Tu Tran on 7/27/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import "UIImage+Support.h"

@implementation UIImage (Support)

+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

@end
