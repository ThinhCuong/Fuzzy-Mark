//
//  Constant.h
//  FuzzyMark
//
//  Created by Tu Tran on 5/5/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#ifndef Constant_h
#define Constant_h


#endif /* Constant_h */

/* Enum */
typedef NS_ENUM(NSInteger, CameraControllerError) {
    CaptureSessionAlreadyRunning = 0,
    CaptureSessionIsMissing,
    InputsAreInvalid,
    InvalidOperation,
    Unknown
};

typedef NS_ENUM(NSInteger, CameraPosition) {
    CameraPositionFront,
    CameraPositionRear
};

typedef NS_ENUM(NSInteger, OTPType) {
    OTPTypeRegister,
    OTPTypeReset,
    OTPTypeOther
};

typedef NS_ENUM(NSInteger, LoginType) {
    LoginTypeSignIn,
    LoginTypeSignUp,
    LoginTypeForgotPassword
};

typedef NS_ENUM(NSInteger, StatusType) {
    StausTypeREQUEST = 1,
    StausTypeAPPROVED = 2,
    StausTypeDENY = 3
};

typedef NS_ENUM(NSInteger, RateConfigsFlag) {
    RateConfigsFlagLow,
    RateConfigsFlagMedium,
    RateConfigsFlagHigh
};

/* Name API */
#define GET_HISTORIES_CAPTURE                       @"user/histories-capture"
#define GET_USER_NOTIFICATIONS                      @"user/notifications"
#define PUT_USER_NOTIFICATIONS_READ                 @"user/notifications/read"
#define PUT_USER_NOTIFICATIONS_READ_ALL             @"user/notifications/read-all"
#define GET_HISTORIES_REWARD                        @"user/histories-reward"
#define GET_CONFIGURATION                           @"configuration"
#define POST_USER_UPLOAD_BILLS                      @"user/upload-bills"
#define POST_USER_UPLOAD_AVATAR                     @"user/upload-avatar"
#define GET_VOUCHERS_INTERESTED                     @"vouchers/interested"
#define GET_USER_BILL_DETAIL                        @"user/bill-detail"
#define GET_USER_PROFILE                            @"user/profile"
#define POST_USER_LOGIN                             @"user/login"
#define POST_USER_REGISTER                          @"user/register"
#define POST_USER_RESEND_OTP                        @"user/resend-otp"
#define POST_USER_CHECK_OTP                         @"user/check-otp"
#define PUT_USER_CHANGE_PASSWORD                    @"user/change-password"
#define PUT_USER_UPDATE_PROFILE                     @"user/update-profile"
#define GET_HOME_DATA                               @"get-home-data"
#define POST_USER_FORGOT_PASSWORD                   @"user/forgot-password"
#define GET_VOUCHERS_SEARCH                         @"vouchers/search"
#define GET_VOUCHERS_INFO                           @"vouchers/info"
#define GET_VOUCHERS_INTERESTED                     @"vouchers/interested"
#define POST_VOUCHERS_ADD_INTERESTED                @"vouchers/add-interested"
#define GET_NEWS_GET_NEWS                           @"news/get-news"
#define GET_NEWS_FULL_NEWS                          @"news/full-news"
#define GET_PAGES_INFO                              @"pages/info"
#define GET_PAGES_INTERESTED                        @"pages/interested"
#define POST_PAGES_ADD_INTERESTED                   @"pages/add-interested"
#define DELETE_PAGES_DELETE_INTERESTED              @"pages/delete-interested"
#define GET_PAGES_RATES_PAGE                        @"pages/rates-page"
#define POST_PAGES_RATE                             @"pages/rate"
#define GET_NEWS_FULL_NEWS                          @"news/full-news"

/* Value */
#define NUMBER_ITEM_CALL_API                        @50
#define isLoggedIn                                  (BOOL)(([UserInfo getUserToken] != nil) && ([UserInfo getUserToken].length > 0))

/* Color */
#define klineColorNormal                            [UIColor colorWithRed:0.85 green:0.85 blue:0.85 alpha:1.0]
#define klineColorSuccess                           [UIColor colorWithRed:0.161 green:0.631 blue:0.612 alpha:1.0]
#define klineColorError                             [UIColor colorWithRed:1.0 green:0.086 blue:0.117 alpha:1.0]
#define UIColorFromRGBA(r, g, b, a)                 [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

/* Notication */
#define kNotificationCenterChangeStatusUser         @"NotificationCenterChangeStatusUser"
#define kNotificationCenterConfigAppSuccess         @"kNotificationCenterConfigAppSuccess"

/* String */
#define kMessageError                               @"Có lỗi xẩy ra, vui lòng thử lại sau"

/* Image */
#define kLogoPlaceholderImage                       [UIImage imageNamed:@"logo_placeholder"]
#define kUserPlaceholderImage                       [UIImage imageNamed:@"ic_user"]

