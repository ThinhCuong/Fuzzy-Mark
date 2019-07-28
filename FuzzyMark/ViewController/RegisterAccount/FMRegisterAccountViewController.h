//
//  FMRegisterAccountViewController.h
//  FuzzyMark
//
//  Created by Tu Tran on 7/21/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserInformation.h"

NS_ASSUME_NONNULL_BEGIN

@interface FMRegisterAccountViewController : FMBaseViewController
@property (nonatomic, copy) void(^registerSuccess)(void);
- (instancetype)initWithUser:(UserInformation *) userModel;
@end

NS_ASSUME_NONNULL_END
