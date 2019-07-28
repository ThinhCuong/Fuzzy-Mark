//
//  FMOTPChangeEmailViewController.h
//  FuzzyMark
//
//  Created by Tu Tran on 5/19/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol FMOTPViewControllerDelegate <NSObject>
- (void)checkOTPSuccess:(BOOL) isSuccess;
@end

@interface FMOTPViewController : FMBaseViewController
@property (assign, nonatomic) id<FMOTPViewControllerDelegate> delegate;
- (instancetype)initWithTitleAttributedString:(NSAttributedString *) attributedString EmailSendOTP:(NSString *) email withType:(OTPType) type;
@end

NS_ASSUME_NONNULL_END
