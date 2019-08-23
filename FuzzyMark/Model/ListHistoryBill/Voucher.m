//
//  Voucher.m
//  FuzzyMark
//
//  Created by Tu Tran on 5/5/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import "Voucher.h"

@implementation Voucher

- (instancetype)initWithDataDictionary:(NSDictionary *)data {
    self = [super init];
    if (self) {
        self.idVoucher = [data integerForKey:@"id"];
        self.descriptionVoucher = [data stringForKey:@"description"];
        self.name = [data stringForKey:@"name"];
        self.image = [data stringImageForKey:@"image"];
        self.logo = [data stringForKey:@"id"];
        self.percent_discount = [data integerForKey:@"percent_discount"];
        self.page = [[Page alloc] initWithDataDictionary:[data dictionaryForKey:@"page"]];
        self.count_down = [data integerForKey:@"count_down"];
        self.time_bookmark = [data stringForKey:@"time_bookmark"];
    }
    return self;
}


@end
