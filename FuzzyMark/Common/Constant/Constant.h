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

/* Name API */
#define GET_HISTORIES_CAPTURE                @"user/histories-capture"
#define GET_USER_NOTIFICATIONS               @"user/notifications"
#define PUT_USER_NOTIFICATIONS_READ          @"user/notifications/read"
#define PUT_USER_NOTIFICATIONS_READ_ALL      @"user/notifications/read-all"

/* Value */
#define NUMBER_ITEM_CALL_API   @50
