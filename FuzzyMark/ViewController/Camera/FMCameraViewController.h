//
//  FMCameraViewController.h
//  FuzzyMark
//
//  Created by Tu Tran on 5/3/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <UIKit/UIKit.h>
#import "FMCameraShowImageVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface FMCameraViewController : FMBaseViewController
@property (strong, nonatomic) FMCameraShowImageVC *showImageVC;
- (instancetype)initWithVoucherID:(NSInteger) voucher_id;
@end

NS_ASSUME_NONNULL_END
