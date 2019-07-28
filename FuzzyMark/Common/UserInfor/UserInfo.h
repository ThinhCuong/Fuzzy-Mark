//
//  UserInfo.h
//  FuzzyMark
//
//  Created by Tu Tran on 7/21/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef enum {
    FMUserStateDidLogin = 0,
    FMUserStateNotLogin = -1,
    FMUserStateLoginOnOtherDevice = -2
} MVUserState;

@interface UserInfo : NSObject
+ (void)setUserID:(NSInteger) userID;
+ (NSInteger)getUserID;

+ (void)setUserName:(NSString *) userName;
+ (NSString *)getUserName;

+ (void)setUserAvatar:(NSString *) userAvatar;
+ (NSString *)getUserAvatar;

+ (void)setUserEmail:(NSString *) userEmail;
+ (NSString *)getUserEmail;

+ (void)setUserPhone:(NSString *) userPhone;
+ (NSString *)getUserPhone;

+ (void)setUserPointReward:(NSInteger) userPointReward;
+ (NSInteger)getUserPointReward;

+ (void)setUserHistoryCount:(NSInteger) userHistoryCount;
+ (NSInteger)getUserHistoryCount;

+ (void)setUserToken:(NSString *) userToken;
+ (NSString *)getUserToken;
@end

NS_ASSUME_NONNULL_END
