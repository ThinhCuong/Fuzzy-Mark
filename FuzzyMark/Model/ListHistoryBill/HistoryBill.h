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

@interface HistoryBill : NSObject

@property (nonatomic) NSInteger transaction_id;
@property (nonatomic) NSInteger status;
@property (nonatomic) Voucher *voucher;
@property (nonatomic) NSString *time;
@property (nonatomic) NSString *reason;
- (instancetype)initWithDataDictionary:(NSDictionary *)data;

@end

NS_ASSUME_NONNULL_END
