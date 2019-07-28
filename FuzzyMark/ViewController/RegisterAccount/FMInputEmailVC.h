//
//  FMInputPhoneNumberVC.h
//  FuzzyMark
//
//  Created by Tu Tran on 7/28/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FMInputEmailVC : FMBaseViewController
@property (nonatomic, copy) void(^registerSuccess)(void);
@end

NS_ASSUME_NONNULL_END
