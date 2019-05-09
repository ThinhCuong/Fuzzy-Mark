//
//  FZHomeJsonModel.h
//  FuzzyMark
//
//  Created by Nguyen Cuong on 5/6/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

//#import <JSONModel/JSONModel.h>

NS_ASSUME_NONNULL_BEGIN

@protocol FZBannerModel;
@protocol FZFixedAdsJsonModel;
@protocol FZIconGroupJsonModel;
@protocol FZGroupJsonModel;

@class FZBannerModel;
@class FZFixedAdsJsonModel;
@class FZIconGroupJsonModel;
@class FZGroupJsonModel;

@interface FZHomeJsonModel : JSONModel

@property (nonatomic, strong, nullable) NSArray <FZBannerModel*> <FZBannerModel> *banners;
@property (nonatomic) NSArray <FZFixedAdsJsonModel *> <FZFixedAdsJsonModel> *fixed_ads;
@property (nonatomic) NSArray <FZIconGroupJsonModel *> <FZIconGroupJsonModel> *icon_groups;
@property (nonatomic) NSArray <FZGroupJsonModel *> <FZGroupJsonModel>*groups;

@end

@protocol FZBannerModel;
@interface FZBannerModel : JSONModel

@property (nonatomic) NSInteger id;
@property (nonatomic) NSString *image;

@end

@interface FZFixedAdsJsonModel : JSONModel

@property (nonatomic) NSString *url;
@property (nonatomic) NSString *image;

@end

@interface FZIconGroupJsonModel : JSONModel

@property (nonatomic) NSInteger id;
@property (nonatomic) NSString *title;
@property (nonatomic) NSString *image;

@end

@protocol FZGroupInfoJsonModel;
@class FZGroupInfoJsonModel;

@interface FZGroupJsonModel : JSONModel

@property (nonatomic) NSInteger id;
@property (nonatomic) NSString *title;
@property (nonatomic) NSArray <FZGroupInfoJsonModel *> <FZGroupInfoJsonModel> *vouchers_vertical;
@property (nonatomic) NSArray <FZGroupInfoJsonModel *> <FZGroupInfoJsonModel> *vouchers_horizontal;

@end

@protocol FZGroupInfoJsonModel;
@class FZPageJsonModel;

@interface FZGroupInfoJsonModel : JSONModel

@property (nonatomic) NSInteger id;
@property (nonatomic) NSString *name;
@property (nonatomic) NSString *image;
@property (nonatomic) NSString *logo;
@property (nonatomic) NSString *groupInfoDescription;
@property (nonatomic) NSInteger percent_discount;
@property (nonatomic) FZPageJsonModel *page;
@end

@class FZLocationJsonModel;
@interface FZPageJsonModel : JSONModel

@property (nonatomic) NSInteger id;
@property (nonatomic) NSString *name;
@property (nonatomic) NSString *address;
@property (nonatomic) NSInteger rate_count;
@property (nonatomic) NSInteger total_rate;
@property (nonatomic) NSString *image;
@property (nonatomic) NSString *open_time;
@property (nonatomic) NSString *close_time;
@property (nonatomic) NSString *hotline;
@property (nonatomic) NSString *min_price;
@property (nonatomic) NSString *max_price;
@property (nonatomic) FZLocationJsonModel *location;

@end

@interface FZLocationJsonModel : JSONModel

@property (nonatomic) NSInteger lat;
@property (nonatomic) NSInteger lng;

@end
NS_ASSUME_NONNULL_END
