//
//  ConfigApp.h
//  FuzzyMark
//
//  Created by Tu Tran on 8/17/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ConfigAppObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface ConfigApp : NSObject

+ (void)setConfigAppWithConfigObject:(ConfigAppObject *) obj;
+ (ConfigAppObject *)getConfigApp;

+ (NSArray <Group*> *)getListGroups;
+ (NSArray <Service*> *)getListSubServices;
+ (NSArray <Promotion*> *)getListPromotion;

+ (RateConfig *)getRateConfig;
+ (NSArray <NSString *> *)getListRateConfigLow;
+ (NSArray <NSString *> *)getListRateConfigMedium;
+ (NSArray <NSString *> *)getListRateConfigHigh;


@end

NS_ASSUME_NONNULL_END
