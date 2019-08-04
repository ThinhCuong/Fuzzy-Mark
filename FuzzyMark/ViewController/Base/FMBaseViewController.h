//
//  FMBaseViewController.h
//  FuzzyMark
//
//  Created by Tu Tran on 5/1/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FMBaseViewController : UIViewController
@property (assign, nonatomic) BOOL hideNav;
@property (assign, nonatomic) BOOL hideBottomLineNav;
@property (strong, nonatomic) NSString *navBackBtnTitle;
@property (strong, nonatomic) NSString *navTitle;
@end

NS_ASSUME_NONNULL_END
