//
//  Page.m
//  FuzzyMark
//
//  Created by Tu Tran on 5/5/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import "Page.h"

@implementation Page

- (instancetype)initWithDataDictionary:(NSDictionary *)data {
    self = [super init];
    if (self) {
        self.idPage = [data integerForKey:@"id"];
        self.name = [data stringForKey:@"name"];
        self.address = [data stringImageForKey:@"address"];
        self.rate_count = [data integerForKey:@"rate_count"];
        self.total_rate = [data integerForKey:@"total_rate"];
        self.image = [data stringImageForKey:@"image"];
        self.open_time = [data stringImageForKey:@"open_time"];
        self.close_time = [data stringImageForKey:@"close_time"];
        self.hotline = [data stringImageForKey:@"hotline"];
        self.min_price = [data integerForKey:@"min_price"];
        self.max_price = [data integerForKey:@"max_price"];
    }
    return self;
}

@end
