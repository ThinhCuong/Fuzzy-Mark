//
//  PageInfo.m
//  FuzzyMark
//
//  Created by Tu Tran on 8/30/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import "PageInfo.h"

@implementation PageInfo

- (instancetype)initWithDataDictionary:(NSDictionary *) data
{
    self = [super init];
    if (self) {
        self.page_view = [[PageObject alloc] initWithDataDictionary:[data dictionaryForKey:@"page_view"]];
        self.hot_voucher = [[Voucher alloc] initWithDataDictionary:[data dictionaryForKey:@"hot_voucher"]];
        self.descriptionPageInfo = [data stringForKey:@"description"];
        self.short_description = [data stringForKey:@"short_description"];
        
        NSMutableArray *listVouchers = [NSMutableArray new];
        for (NSDictionary *dict in [data arrayForKey:@"vouchers"]) {
            Voucher *obj = [[Voucher alloc] initWithDataDictionary:dict];
            [listVouchers addObject:obj];
        }
        self.vouchers = listVouchers.copy;
        
        NSMutableArray *listRates = [NSMutableArray new];
        for (NSDictionary *dict in [data arrayForKey:@"rates"]) {
            RageView *obj = [[RageView alloc] initWithDataDictionary:dict];
            [listRates addObject:obj];
        }
        self.rates = listRates.copy;
        
        NSMutableArray *listAlbums = [NSMutableArray new];
        for (NSDictionary *dict in [data arrayForKey:@"albums"]) {
            AlbumView *obj = [[AlbumView alloc] initWithDataDictionary:dict];
            [listAlbums addObject:obj];
        }
        self.albums = listAlbums.copy;
        
        self.is_rate = [data boolForKey:@"is_rate"];
    }
    return self;
}

@end

@implementation RageView

- (instancetype)initWithDataDictionary:(NSDictionary *) data
{
    self = [super init];
    if (self) {
        self.user = [[UseView alloc] initWithDict:[data dictionaryForKey:@"user"]];
        self.point = [data integerForKey:@"point"];
        self.comment = [data stringForKey:@"comment"];
        self.time = [data stringForKey:@"time"];
    }
    return self;
}

@end

@implementation AlbumView

- (instancetype)initWithDataDictionary:(NSDictionary *) data
{
    self = [super init];
    if (self) {
        self.name = [data stringForKey:@"name"];
        self.type = [data stringForKey:@"type"];
        NSMutableArray *listFile = [NSMutableArray new];
        for (NSString *url in [data arrayForKey:@"files"]) {
            [listFile addObject:url];
        }
        self.files = listFile.copy;
    }
    return self;
}

@end
