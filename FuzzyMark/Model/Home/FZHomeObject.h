//
//  FZHomeObject.h
//  FuzzyMark
//
//  Created by Nguyen Cuong on 7/28/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class GroupInfoObject;
@interface FZHomeObject : NSObject

@property (strong, nonatomic) NSArray *banners;
@property (strong, nonatomic) NSArray *fixedAds;
@property (strong, nonatomic) NSArray *iconGroups;
@property (strong, nonatomic) NSArray <GroupInfoObject *> *groups;

- (instancetype)initWithDataDictionary:(NSDictionary *)dict;

@end

@interface BannerObject : NSObject

@property (assign, nonatomic) NSInteger bannerId;
@property (strong, nonatomic) NSString *image;
@property (assign, nonatomic) NSInteger bannerType;
@property (assign, nonatomic) NSInteger voucherId;
@property (strong, nonatomic) NSString *urlAds;

- (instancetype)initWithDataDictionary:(NSDictionary *)dict;

@end

@interface FixedAdsObject : NSObject

@property (assign, nonatomic) NSInteger adId;
@property (strong, nonatomic) NSString *imageAds;
@property (assign, nonatomic) NSInteger adType;
@property (assign, nonatomic) NSInteger voucherId;
@property (strong, nonatomic) NSString *urlAds;

- (instancetype)initWithDataDictionary:(NSDictionary *)dict;

@end

@interface IConObject : NSObject

@property (assign, nonatomic) NSInteger adId;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *image;

- (instancetype)initWithDataDictionary:(NSDictionary *)dict;

@end

@interface GroupInfoObject : NSObject

@property (assign, nonatomic) NSInteger groupId;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSArray *vouchersHorizontal;
@property (strong, nonatomic) NSArray *vouchersVertical;

- (instancetype)initWithDataDictionary:(NSDictionary *)dict;

@end

@class PageObject;
@interface RewardObject : NSObject

@property (assign, nonatomic) NSInteger rewardId;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *image;
@property (strong, nonatomic) NSString *logo;
@property (strong, nonatomic) NSString *rewardDescription;
@property (assign, nonatomic) NSInteger percentDiscount;
@property (strong, nonatomic) PageObject *page;
@property (assign, nonatomic) NSInteger countDown;

- (instancetype)initWithDataDictionary:(NSDictionary *)dict;

@end

@class LocationObject;
@interface PageObject : NSObject

@property (assign, nonatomic) NSInteger pageId;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *logo;
@property (strong, nonatomic) LocationObject *location;
@property (strong, nonatomic) NSString *address;
@property (assign, nonatomic) NSInteger rate_count;
@property (assign, nonatomic) NSInteger total_rate;
@property (strong, nonatomic) NSString *image;
@property (strong, nonatomic) NSString *open_time;
@property (strong, nonatomic) NSString *close_time;
@property (strong, nonatomic) NSString *hotline;
@property (strong, nonatomic) NSString *range_price;
@property (assign, nonatomic) NSInteger discount;

- (instancetype)initWithDataDictionary:(NSDictionary *)dict;

@end

@interface LocationObject : NSObject

@property (strong, nonatomic) NSString *lat;
@property (strong, nonatomic) NSString *lng;

- (instancetype)initWithDataDictionary:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
