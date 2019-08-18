//
//  FMLoginAccountViewController.h
//  FuzzyMark
//
//  Created by Tu Tran on 7/28/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FMLoginAccountViewController : FMBaseViewController
@property (copy, nonatomic) void (^loginSuccess)(BOOL);
@end

NS_ASSUME_NONNULL_END
