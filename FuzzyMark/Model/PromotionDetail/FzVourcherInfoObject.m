//
//  FzVourcherInfoObject.m
//  FuzzyMark
//
//  Created by Nguyen Cuong on 8/3/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import "FzVourcherInfoObject.h"

@implementation FzVourcherInfoObject

- (instancetype)initWithDataDictionary:(NSDictionary *)data {
    self = [super init];
    if (self) {
        self.countReceived = [data integerForKey:@"count_received"];
        self.intro = [data stringForKey:@"intro"];
        if (![[data dictionaryForKey:@"voucher"] isEmpty]) {
            RewardObject *vourcherInfo = [[RewardObject alloc] initWithDataDictionary:[data dictionaryForKey:@"voucher"]];
            self.voucher = vourcherInfo;
        }
        
        NSMutableArray *listPage = [NSMutableArray new];
        for (NSDictionary *dict in [data arrayForKey:@"accepted_page"]) {
            PageObject *pageInfo = [[PageObject alloc] initWithDataDictionary:dict];
            [listPage addObject:pageInfo];
        }
        self.acceptedPage = listPage.copy;
        
        NSMutableArray *listVoucher= [NSMutableArray new];
        for (NSDictionary *dict in [data arrayForKey:@"related_vouchers"]) {
            RewardObject *vourcherInfo = [[RewardObject alloc] initWithDataDictionary:dict];
            [listVoucher addObject:vourcherInfo];
        }
        self.relatedVouchers = listVoucher.copy;
        
    }
    return self;
}

@end

