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
    OTPTypeReset
};

/* Name API */
#define GET_HISTORIES_CAPTURE                       @"user/histories-capture"
#define GET_USER_NOTIFICATIONS                      @"user/notifications"
#define PUT_USER_NOTIFICATIONS_READ                 @"user/notifications/read"
#define PUT_USER_NOTIFICATIONS_READ_ALL             @"user/notifications/read-all"

/* Value */
#define NUMBER_ITEM_CALL_API                        @50
#define isLoggedIn                                  (BOOL)(([UserInfo getUserToken] != nil) && ([UserInfo getUserToken].length > 0))

/* Color */
#define klineColorNormal                            [UIColor colorWithRed:0.85 green:0.85 blue:0.85 alpha:1.0]
#define klineColorSuccess                           [UIColor colorWithRed:0.161 green:0.631 blue:0.612 alpha:1.0]
#define klineColorError                             [UIColor colorWithRed:1.0 green:0.086 blue:0.117 alpha:1.0]

/* Notication */
#define kNotificationCenterChangeStatusUser       @"NotificationCenterChangeStatusUser"
