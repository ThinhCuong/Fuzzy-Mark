//
//  FZSearchModel.h
//  FuzzyMark
//
//  Created by Nguyen Cuong on 5/27/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class Group;
@class Category;
@class RateConfig;
@class Service;
@class Promotion;

@interface ConfigAppObject : NSObject

@property (strong, nonatomic) NSArray <Group*> *groups;
@property (strong, nonatomic) NSArray <Service*> *sub_services;
@property (strong, nonatomic) RateConfig *rate_configs;
@property (strong, nonatomic) NSArray <Promotion*> *promotions;
- (instancetype)initWithDataDictionary:(NSDictionary *) data;

@end

@interface Group : NSObject <NSCopying>

@property (assign, nonatomic) NSInteger idGroup;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *icon;
@property (strong, nonatomic) NSArray <Category *> *categories;
- (instancetype)initWithDataDictionary:(NSDictionary *) data;
@end

@interface Category : NSObject

@property (assign ,nonatomic) NSInteger idCategory;
@property (strong ,nonatomic) NSString *name;
@property (strong ,nonatomic) NSString *image;
- (instancetype)initWithDataDictionary:(NSDictionary *) data;

@end

@interface Service : NSObject
@property (assign, nonatomic) NSInteger idService;
@property (strong, nonatomic) NSString *name;
- (instancetype)initWithDataDictionary:(NSDictionary *) data;

@end

@interface RateConfig : NSObject
@property (strong, nonatomic) NSArray <NSString*> *low;
@property (strong, nonatomic) NSArray <NSString*> *medium;
@property (strong, nonatomic) NSArray <NSString*> *high;
- (instancetype)initWithDataDictionary:(NSDictionary *) data;

@end

@interface Promotion : NSObject
@property (assign, nonatomic) NSInteger idPromotion;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *image;
@property (strong, nonatomic) NSString *logo;
@property (assign, nonatomic) NSInteger percentDiscount;
- (instancetype)initWithDataDictionary:(NSDictionary *) data;

@end

NS_ASSUME_NONNULL_END
