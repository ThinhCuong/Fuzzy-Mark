//
//  LocationFavoriteObj.m
//  FuzzyMark
//
//  Created by Tu Tran on 7/30/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import "LocationFavoriteObj.h"

@implementation LocationFavoriteObj

- (instancetype)initWithDict:(NSDictionary *) dict
{
    self = [super init];
    if (self) {
        self.idLocation = [dict integerForKey:@"id"];
        self.name = [dict stringForKey:@"name"];
        self.location = [[Location alloc] initWithDictionary:[dict dictionaryForKey:@"location"] error:nil];
        self.address = [dict stringForKey:@"address"];
        self.rate_count = [dict integerForKey:@"rate_count"];
        self.total_rate = [dict integerForKey:@"total_rate"];
        self.image = [dict stringForKey:@"image"];
        self.open_time = [dict stringForKey:@"open_time"];
        self.close_time = [dict stringForKey:@"close_time"];
        self.hotline = [dict stringForKey:@"hotline"];
        self.range_price = [dict stringForKey:@"range_price"];
        self.discount = [dict integerForKey:@"discount"];
    }
    return self;
}

@end
