//
//  MVPromotionDetailModel.h
//  FuzzyMark
//
//  Created by Tu Tran on 6/16/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VoucherInfoJsonModel.h"

NS_ASSUME_NONNULL_BEGIN
@protocol FMPromotionDetailModelDelegate <NSObject>

- (void)getDataSuccess:(VoucherInfoJsonModel *) voucherInfo;
- (void)getDataFail;
- (void)getDataError;

@end
@interface FMPromotionDetailModel : NSObject

@property (assign, nonatomic) id<FMPromotionDetailModelDelegate> delegate;
- (void)getVouchersInfoWithIDVoucher:(NSString *) idVoucher;

@end

NS_ASSUME_NONNULL_END
