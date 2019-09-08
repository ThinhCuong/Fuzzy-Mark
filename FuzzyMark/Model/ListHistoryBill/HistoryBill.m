//
//  RegisterPromotion.m
//  FuzzyMark
//
//  Created by Tu Tran on 5/5/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import "HistoryBill.h"

@implementation HistoryBill

- (instancetype)initWithDataDictionary:(NSDictionary *)data {
    self = [super init];
    if (self) {
        self.transaction_id = [data integerForKey:@"transaction_id"];
        self.status = [data integerForKey:@"status"];
        self.voucher = [[Voucher alloc] initWithDataDictionary:[data dictionaryForKey:@"voucher"]];
        self.time = [data stringForKey:@"time"];
        self.reason = [data stringForKey:@"reason"];
    }
    return self;
}

@end
