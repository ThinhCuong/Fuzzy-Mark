//
//  RegisterPromotion.h
//  FuzzyMark
//
//  Created by Tu Tran on 5/5/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Voucher.h"

NS_ASSUME_NONNULL_BEGIN

@interface HistoryBill : JSONModel

@property (strong, nonatomic) NSString <Optional> *transaction_id;
@property (strong, nonatomic) NSNumber <Optional> *status;
@property (strong, nonatomic) Voucher <Optional> *voucher;
@property (strong, nonatomic) NSString <Optional> *time;
@property (strong, nonatomic) NSString <Optional> *reason;

@end

NS_ASSUME_NONNULL_END
