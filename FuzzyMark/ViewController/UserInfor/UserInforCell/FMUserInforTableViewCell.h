//
//  FMUserInforTableViewCell.h
//  FuzzyMark
//
//  Created by Tu Tran on 4/14/19.
//  Copyright © 2019 Tu Tran. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserInformation.h"

NS_ASSUME_NONNULL_BEGIN
@protocol FMUserInforTableViewCellProtocol <NSObject>
- (void)didSelectButtonHistory;
- (void)didSelectButtonPoint;
- (void)didSelectButtonAddImageUser;
- (void)didSelectEmailView;
- (void)didSelectPhoneView;
@end

@interface FMUserInforTableViewCell : UITableViewCell
- (void)binDataLoginWithUserInfor:(UserInformation *) userInfo;
- (void)binDataNotLogin;
@property (assign, nonatomic) id<FMUserInforTableViewCellProtocol> delegate;
@end

NS_ASSUME_NONNULL_END
