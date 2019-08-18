//
//  FMCameraShowImage.h
//  FuzzyMark
//
//  Created by Tu Tran on 5/29/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FMCameraShowImageVC : UIViewController
@property (weak, nonatomic) NSMutableArray <UIImage *> *listImage;
- (instancetype)initWithVoucherID:(NSInteger) voucher_id;
@end

NS_ASSUME_NONNULL_END
