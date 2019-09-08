//
//  TransactionInfoObject.m
//  FuzzyMark
//
//  Created by Tu Tran on 8/24/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import "TransactionInfoObject.h"

@implementation TransactionInfoObject

- (instancetype)initWithDataDictionary:(NSDictionary *) data
{
    self = [super init];
    if (self) {
        self.transaction_view = [[HistoryBill alloc] initWithDataDictionary:data[@"transaction_view"]];
        NSMutableArray *arr = [NSMutableArray new];
        for (NSDictionary *dict in [data arrayForKey:@"images"]) {
            Url *url = [[Url alloc] initWithDataDictionary:dict];
            [arr addObject:url];
        }
        self.images = arr.copy;
        self.time_take_voucher = [data stringForKey:@"time_take_voucher"];
        self.time_send_request = [data stringForKey:@"time_send_request"];
        self.time_check = [data stringForKey:@"time_check"];
    }
    return self;
}

@end

@implementation Url

- (instancetype)initWithDataDictionary:(NSDictionary *) data {
    self = [super init];
    if (self) {
        self.url = [data stringForKey:@"url"];
    }
    return self;
}
@end

