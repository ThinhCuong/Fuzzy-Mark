//
//  UserInfo.m
//  FuzzyMark
//
//  Created by Tu Tran on 7/21/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import "UserInfo.h"
#import "ConstantUserInfor.h"

@implementation UserInfo
+ (void)resetUserData {
    [UserInfo resetStringNSUserDefaultWithKey:USER_ID];
    [UserInfo resetStringNSUserDefaultWithKey:USER_NAME];
    [UserInfo resetStringNSUserDefaultWithKey:USER_AVATAR];
    [UserInfo resetStringNSUserDefaultWithKey:USER_EMAIL];
    [UserInfo resetStringNSUserDefaultWithKey:USER_PHONE];
    [UserInfo resetStringNSUserDefaultWithKey:USER_TOKEN];
    [UserInfo resetIntergerNSUserDefaultWithKey:USER_POIN_REWARD];
    [UserInfo resetIntergerNSUserDefaultWithKey:USER_HISTORY_COUNT];
}

+ (void)setUserInforWithUserModel:(UserInformation *) userModel {
    [UserInfo setUserID:userModel.user_view.idUser];
    [UserInfo setUserName:userModel.user_view.name];
    [UserInfo setUserEmail:userModel.email];
    [UserInfo setUserAvatar:userModel.user_view.avatar];
    [UserInfo setUserPhone:userModel.phone];
    [UserInfo setUserPointReward:userModel.point_reward];
    [UserInfo setUserHistoryCount:userModel.history_count];
    [UserInfo setUserToken:userModel.token];
}
+ (UserInformation *)getUserInforModel {
    UserInformation *userModel = [UserInformation new];
    userModel.user_view.idUser = [UserInfo getUserID];
    userModel.user_view.name = [UserInfo getUserName];
    userModel.user_view.avatar = [UserInfo getUserAvatar];
    userModel.email = [UserInfo getUserEmail];
    userModel.phone = [UserInfo getUserPhone];
    userModel.point_reward = [UserInfo getUserPointReward];
    userModel.history_count = [UserInfo getUserHistoryCount];
    userModel.token = [UserInfo getUserToken];
    return userModel;
}

+ (void)setUserID:(NSInteger) userID {
    [UserInfo setIntergerNSUserDefaultsWithInterger:userID andKey:USER_ID];
}
+ (NSInteger)getUserID {
    return [UserInfo getIntergerNSUserDefaultsWithKey:USER_ID];
}

+ (void)setUserName:(NSString *) userName {
    [UserInfo setStringNSUserDefaultsWithString:userName andKey:USER_NAME];
}
+ (NSString *)getUserName {
    return [UserInfo getStringNSUserDefaultsWithKey:USER_NAME];
}

+ (void)setUserAvatar:(NSString *) userAvatar {
    [UserInfo setStringNSUserDefaultsWithString:userAvatar andKey:USER_AVATAR];
}
+ (NSString *)getUserAvatar {
    return [UserInfo getStringNSUserDefaultsWithKey:USER_AVATAR];
}

+ (void)setUserEmail:(NSString *) userEmail {
    [UserInfo setStringNSUserDefaultsWithString:userEmail andKey:USER_EMAIL];
}
+ (NSString *)getUserEmail {
    return [UserInfo getStringNSUserDefaultsWithKey:USER_EMAIL];
}

+ (void)setUserPhone:(NSString *) userPhone {
    [UserInfo setStringNSUserDefaultsWithString:userPhone andKey:USER_PHONE];
}
+ (NSString *)getUserPhone {
    return [UserInfo getStringNSUserDefaultsWithKey:USER_PHONE];
}

+ (void)setUserPointReward:(NSInteger) userPointReward {
    [UserInfo setIntergerNSUserDefaultsWithInterger:userPointReward andKey:USER_POIN_REWARD];
}
+ (NSInteger)getUserPointReward {
    return [UserInfo getIntergerNSUserDefaultsWithKey:USER_POIN_REWARD];
}

+ (void)setUserHistoryCount:(NSInteger) userHistoryCount {
    [UserInfo setIntergerNSUserDefaultsWithInterger:userHistoryCount andKey:USER_HISTORY_COUNT];
}
+ (NSInteger)getUserHistoryCount {
    return [UserInfo getIntergerNSUserDefaultsWithKey:USER_HISTORY_COUNT];
}

+ (void)setUserToken:(NSString *) userToken {
    [UserInfo setStringNSUserDefaultsWithString:userToken andKey:USER_TOKEN];
}
+ (NSString *)getUserToken {
    return [UserInfo getStringNSUserDefaultsWithKey:USER_TOKEN];
}

+ (void)setStringNSUserDefaultsWithString:(NSString *) string andKey:(NSString *) key {
    if (key.length == 0) {
        key = @"";
    }
    [[NSUserDefaults standardUserDefaults] setObject:string forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (NSString *)getStringNSUserDefaultsWithKey:(NSString *) key {
    NSString *reg = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    if (reg.length == 0) {
        reg = @"";
    }
    return reg;
}
+ (void)resetStringNSUserDefaultWithKey:(NSString *) key {
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:key];
}

+ (void)setIntergerNSUserDefaultsWithInterger:(NSInteger) interger andKey:(NSString *) key {
    [[NSUserDefaults standardUserDefaults] setInteger:interger forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (NSInteger)getIntergerNSUserDefaultsWithKey:(NSString *) key {
    NSInteger interger = [[NSUserDefaults standardUserDefaults] integerForKey:key];
    return interger;
}
+ (void)resetIntergerNSUserDefaultWithKey:(NSString *) key {
    [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:key];
}

@end
