//
//  TransactionInfoObject.h
//  FuzzyMark
//
//  Created by Tu Tran on 8/24/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HistoryBill.h"

NS_ASSUME_NONNULL_BEGIN

@interface TransactionInfoObject : NSObject

@property (strong, nonatomic) HistoryBill *transaction_view;
@property (strong, nonatomic) NSArray <UIImage *> *images;
@property (strong, nonatomic) NSString *time_take_voucher;
@property (strong, nonatomic) NSString *time_send_request;
@property (strong, nonatomic) NSString *time_check;
- (instancetype)initWithDataDictionary:(NSDictionary *) data;

@end

NS_ASSUME_NONNULL_END