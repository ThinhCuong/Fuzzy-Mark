//
//  FZSearchModel.m
//  FuzzyMark
//
//  Created by Nguyen Cuong on 5/27/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import "ConfigAppObject.h"

@implementation ConfigAppObject

- (instancetype)initWithDataDictionary:(NSDictionary *) data {
    self = [super init];
    if (self) {
        NSMutableArray *listGroup = [NSMutableArray new];
        NSMutableArray *listSubServices = [NSMutableArray new];
        NSMutableArray *listPromotions = [NSMutableArray new];
        for (NSDictionary *dict in [data arrayForKey:@"groups"]) {
            Group *obj = [[Group alloc] initWithDataDictionary:dict];
            [listGroup addObject:obj];
        }
        for (NSDictionary *dict in [data arrayForKey:@"sub_services"]) {
            Service *obj = [[Service alloc] initWithDataDictionary:dict];
            [listSubServices addObject:obj];
        }
        for (NSDictionary *dict in [data arrayForKey:@"promotions"]) {
            Promotion *obj = [[Promotion alloc] initWithDataDictionary:dict];
            [listPromotions addObject:obj];
        }
        self.groups = listGroup.copy;
        self.sub_services = listSubServices.copy;
        self.promotions = listPromotions.copy;
        self.rate_configs = [[RateConfig alloc] initWithDataDictionary:[data dictionaryForKey:@"rate_configs"]];
    }
    return self;
}

@end

@implementation Group

- (instancetype)initWithDataDictionary:(NSDictionary *) data {
    self = [super init];
    if (self) {
        self.idGroup = [data integerForKey:@"id"];
        self.title = [data stringForKey:@"title"];
        self.icon = [data stringImageForKey:@"icon"];
        NSMutableArray *listCategories = [NSMutableArray new];
        for (NSDictionary *dict in [data arrayForKey:@"categories"]) {
            Category *obj = [[Category alloc] initWithDataDictionary:dict];
            [listCategories addObject:obj];
        }
        self.categories = listCategories.copy;
    }
    return self;
}

@end

@implementation Category

- (instancetype)initWithDataDictionary:(NSDictionary *) data {
    self = [super init];
    if (self) {
        self.idCategory = [data integerForKey:@"id"];
        self.name = [data stringForKey:@"name"];
        self.image = [data stringImageForKey:@"image"];
    }
    return self;
}

@end

@implementation Service

- (instancetype)initWithDataDictionary:(NSDictionary *) data {
    self = [super init];
    if (self) {
        self.idService = [data integerForKey:@"id"];
        self.name = [data stringForKey:@"name"];
    }
    return self;
}

@end

@implementation RateConfig

- (instancetype)initWithDataDictionary:(NSDictionary *) data {
    self = [super init];
    if (self) {
        self.low = [data arrayForKey:@"low"];
        self.high = [data arrayForKey:@"high"];
        self.medium = [data arrayForKey:@"medium"];
    }
    return self;
}

@end

@implementation Promotion

- (instancetype)initWithDataDictionary:(NSDictionary *) data {
    self = [super init];
    if (self) {
        self.idPromotion = [data integerForKey:@"id"];
        self.name = [data stringForKey:@"name"];
        self.image = [data stringImageForKey:@"image"];
        self.logo = [data stringImageForKey:@"logo"];
        self.percentDiscount = [data integerForKey:@"percent_discount"];
    }
    return self;
}

@end


