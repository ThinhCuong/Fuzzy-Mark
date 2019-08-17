//
//  ConfigApp.m
//  FuzzyMark
//
//  Created by Tu Tran on 8/17/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import "ConfigApp.h"

static ConfigAppObject *_configAppObject = nil;
@implementation ConfigApp

+ (void)setConfigAppWithConfigObject:(ConfigAppObject *) obj {
    _configAppObject = obj ?: [[ConfigAppObject alloc] initWithDataDictionary:@{}];
}
+ (ConfigAppObject *)getConfigApp {
    return _configAppObject ?: [[ConfigAppObject alloc] initWithDataDictionary:@{}];
}

+ (NSArray <Group*> *)getListGroups {
    return _configAppObject.groups ?: [NSArray new];
}
+ (NSArray <Service*> *)getListSubServices {
    return _configAppObject.sub_services ?: [NSArray new];
}
+ (NSArray <Promotion*> *)getListPromotion {
    return _configAppObject.promotions ?: [NSArray new];
}

+ (RateConfig *)getRateConfig {
    return _configAppObject.rate_configs ?: [RateConfig new];
}
+ (NSArray <NSString *> *)getListRateConfigLow {
    return _configAppObject.rate_configs.low ?: [NSArray new];
}
+ (NSArray <NSString *> *)getListRateConfigMedium {
    return _configAppObject.rate_configs.medium ?: [NSArray new];
}
+ (NSArray <NSString *> *)getListRateConfigHigh {
    return _configAppObject.rate_configs.high ?: [NSArray new];
}

@end
