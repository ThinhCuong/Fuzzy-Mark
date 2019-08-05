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

@property (nonatomic) NSNumber <Optional> * id;
@property (nonatomic) NSString <Optional> *image;

@end

@interface FZFixedAdsJsonModel : JSONModel

@property (nonatomic) NSString *url_ads;
@property (nonatomic) NSString *image_ads;

@end

@interface FZIconGroupJsonModel : JSONModel

@property (nonatomic) NSNumber <Optional> * id;
@property (nonatomic) NSString *title;
@property (nonatomic) NSString *image;

@end

@protocol FZGroupInfoJsonModel;
@class FZGroupInfoJsonModel;

@interface FZGroupJsonModel : JSONModel

@property (nonatomic) NSNumber <Optional> * id;
@property (nonatomic) NSString <Optional> *title;
@property (nonatomic) NSArray <FZGroupInfoJsonModel *> <FZGroupInfoJsonModel> *vouchers_vertical;
@property (nonatomic) NSArray <FZGroupInfoJsonModel *> <FZGroupInfoJsonModel> *vouchers_horizontal;

@end

@protocol FZGroupInfoJsonModel;
@class FZPageJsonModel;

@interface FZGroupInfoJsonModel : JSONModel

@property (nonatomic) NSNumber <Optional> * id;
@property (nonatomic) NSString <Optional> *name;
@property (nonatomic) NSString <Optional> *image;
@property (nonatomic) NSString <Optional> *logo;
@property (nonatomic) NSString <Optional> *groupInfoDescription;
@property (nonatomic) NSNumber <Optional> * percent_discount;
@property (nonatomic) FZPageJsonModel <Optional> *page;
@end

@class FZLocationJsonModel;
@interface FZPageJsonModel : JSONModel

@property (nonatomic) NSNumber <Optional> *id;
@property (nonatomic) NSString <Optional> *name;
@property (nonatomic) NSString <Optional> *address;
@property (nonatomic) NSNumber <Optional> *rate_count;
@property (nonatomic) NSNumber <Optional> *total_rate;
@property (nonatomic) NSString <Optional> *image;
@property (nonatomic) NSString <Optional> *open_time;
@property (nonatomic) NSString <Optional> *close_time;
@property (nonatomic) NSString <Optional> *hotline;
@property (nonatomic) NSString <Optional> *min_price;
@property (nonatomic) NSString <Optional> *max_price;
@property (nonatomic) FZLocationJsonModel <Optional> *location;

@end

@interface FZLocationJsonModel : JSONModel

@property (nonatomic) NSNumber <Optional> * lat;
@property (nonatomic) NSNumber <Optional> * lng;

@end

@protocol FZGroupInfoJsonModel;
@class FZGroupInfoJsonModel;

@interface FzVourcherSearch : JSONModel

@property (nonatomic) NSArray <FZGroupInfoJsonModel *> <FZGroupInfoJsonModel> *data;

@end

NS_ASSUME_NONNULL_END
