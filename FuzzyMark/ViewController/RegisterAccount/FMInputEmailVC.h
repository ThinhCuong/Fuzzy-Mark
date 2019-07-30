//
//  FMInputPhoneNumberVC.h
//  FuzzyMark
//
//  Created by Tu Tran on 7/28/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol FMInputEmailVCDelegate <NSObject>

- (void)outputEmailSuccess:(NSString *) email;

@end

@interface FMInputEmailVC : FMBaseViewController

@property (assign, nonatomic) id<FMInputEmailVCDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
