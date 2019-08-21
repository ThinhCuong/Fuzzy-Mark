//
//  MVPromotionDetailModel.h
//  FuzzyMark
//
//  Created by Tu Tran on 6/16/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VoucherInfoJsonModel.h"
#import "FzVourcherInfoObject.h"

NS_ASSUME_NONNULL_BEGIN
@protocol FMPromotionDetailModelDelegate <NSObject>

- (void)getDataSuccess:(FzVourcherInfoObject *) voucherInfo;
- (void)getDataFail;
- (void)getDataError;

@end
@interface FMPromotionDetailModel : NSObject

@property (assign, nonatomic) id<FMPromotionDetailModelDelegate> delegate;

- (void)getVouchersInfoWithIDVoucher:(NSInteger)idVoucher;

@end

NS_ASSUME_NONNULL_END
