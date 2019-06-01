//
//  FMTabBarController.h
//  FuzzyMark
//
//  Created by Tu Tran on 4/13/19.
//  Copyright © 2019 Tu Tran. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FMMiddleButton.h"
#import "UITabBar+FMMiddleButton.h"

NS_ASSUME_NONNULL_BEGIN

@interface FMTabBarController : UITabBarController
@property (strong, nonatomic) FMMiddleButton *middleButton;
@end

NS_ASSUME_NONNULL_END
