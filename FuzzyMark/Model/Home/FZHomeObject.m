//
//  FZHomeObject.m
//  FuzzyMark
//
//  Created by Nguyen Cuong on 7/28/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import "FZHomeObject.h"

@implementation FZHomeObject

- (instancetype)initWithDataDictionary:(NSDictionary *)data {
    self = [super init];
    if (self) {
        // parse banner
        NSMutableArray *listBanner = [NSMutableArray new];
        if (data[@"banners"]) {
            for (NSDictionary *dict in data[@"banners"]) {
                BannerObject *bannerInfo = [[BannerObject alloc] initWithDataDictionary:dict];
                [listBanner addObject:bannerInfo];
            }
            self.banners = listBanner;
        }
        NSMutableArray *listfixedAd = [NSMutableArray new];
        // parse fixed_ads
        if (data[@"fixed_ads"]) {
            for (NSDictionary *dict in data[@"fixed_ads"]) {
                 FixedAdsObject *adInfo = [[FixedAdsObject alloc] initWithDataDictionary:dict];
                [listfixedAd addObject:adInfo];
            }
            self.fixedAds = listfixedAd;
        }
        NSMutableArray *listIcon = [NSMutableArray new];
        // parse icon_groups
        if (data[@"icon_groups"]) {
            for (NSDictionary *dict in data[@"icon_groups"]) {
                IConObject *iconInfo = [[IConObject alloc] initWithDataDictionary:dict];
                [listIcon addObject:iconInfo];
            }
            self.iconGroups = listIcon;
        }
        NSMutableArray *listgroup = [NSMutableArray new];
        // parse groups
        if (data[@"groups"]) {
            for (NSDictionary *dict in data[@"groups"]) {
                GroupInfoObject *groupInfo = [[GroupInfoObject alloc] initWithDataDictionary:dict];
                [listgroup addObject:groupInfo];
            }
            self.groups = listgroup;
        }
    }
    return self;
}


@end

@implementation BannerObject

- (instancetype)initWithDataDictionary:(NSDictionary *)data {
    self = [super init];
    if (self) {
        self.bannerId = [data integerForKey:@"id"];
        self.image = [data stringImageForKey:@"image"];
        self.bannerType = [data integerForKey:@"banner_type"];
        self.voucherId = [data integerForKey:@"id_voucher"];
        self.urlAds = [data stringForKey:@"url_ads"];
    }
    return self;
}

@end

@implementation FixedAdsObject

- (instancetype)initWithDataDictionary:(NSDictionary *)data {
    self = [super init];
    if (self) {
        self.adId = [data integerForKey:@"id"];
        self.imageAds = [data stringImageForKey:@"image_ads"];
        self.adType = [data integerForKey:@"ad_type"];
        self.voucherId = [data integerForKey:@"id_voucher"];
        self.urlAds = [data stringForKey:@"url_ads"];
    }
    return self;
}

@end

@implementation IConObject

- (instancetype)initWithDataDictionary:(NSDictionary *)data {
    self = [super init];
    if (self) {
        self.adId = [data integerForKey:@"id"];
        self.title = [data stringForKey:@"title"];
        self.image = [data stringImageForKey:@"image"];
    }
    return self;
}

@end

@implementation GroupInfoObject

- (instancetype)initWithDataDictionary:(NSDictionary *)data {
    self = [super init];
    if (self) {
        self.groupId = [data integerForKey:@"id"];
        self.title = [data stringForKey:@"title"];
        NSMutableArray *listVoucherHorizontal = [NSMutableArray new];
        if (data[@"vouchers_horizontal"]) {
            for (NSDictionary *dict in data[@"vouchers_horizontal"]) {
                RewardObject *voucherInfo = [[RewardObject alloc] initWithDataDictionary:dict];
                [listVoucherHorizontal addObject:voucherInfo];
            }
            self.vouchersHorizontal = listVoucherHorizontal;
        }
        NSMutableArray *listVoucherVertical = [NSMutableArray new];
        if (data[@"vouchers_vertical"]) {
            for (NSDictionary *dict in data[@"vouchers_vertical"]) {
                RewardObject *voucherInfo = [[RewardObject alloc] initWithDataDictionary:dict];
                [listVoucherVertical addObject:voucherInfo];
            }
            self.vouchersVertical = listVoucherVertical;
        }
    }
    return self;
}


@end

@implementation RewardObject

- (instancetype)initWithDataDictionary:(NSDictionary *)data {
    self = [super init];
    if (self) {
        self.rewardId = [data integerForKey:@"id"];
        self.name = [data stringForKey:@"name"];
        self.image = [data stringImageForKey:@"image"];
        self.logo = [data stringForKey:@"logo"];
        self.rewardDescription = [data stringForKey:@"description"];
        self.percentDiscount = [data integerForKey:@"percent_discount"];
        self.countDown = [data integerForKey:@"count_down"];
        if (data[@"page"]) {
            PageObject *pageInfo = [[PageObject alloc] initWithDataDictionary:data[@"page"]];
            self.page = pageInfo;
        }
    }
    return self;
}


@end

@implementation PageObject

- (instancetype)initWithDataDictionary:(NSDictionary *)data {
    self = [super init];
    if (self) {
        self.pageId = [data integerForKey:@"id"];
        self.name = [data stringForKey:@"name"];
        self.address = [data stringForKey:@"address"];
        self.rate_count = [data integerForKey:@"rate_count"];
        self.total_rate = [data integerForKey:@"total_rate"];
        self.image = [data stringImageForKey:@"image"];
        self.open_time = [data stringForKey:@"open_time"];
        self.close_time = [data stringForKey:@"close_time"];
        self.hotline = [data stringForKey:@"hotline"];
        self.range_price = [data stringForKey:@"range_price"];
        self.discount = [data integerForKey:@"discount"];
        if (![[data dictionaryForKey:@"location"] isEmpty]) {
            LocationObject *location = [[LocationObject alloc] initWithDataDictionary:data[@"location"]];
            self.location = location;
        }
    }
    return self;
}

@end

@implementation LocationObject

- (instancetype)initWithDataDictionary:(NSDictionary *)data {
    self = [super init];
    if (self) {
        self.lat = [data stringForKey:@"lat"];
        self.lng = [data stringForKey:@"lng"];
    }
    return self;
}

@end
