//
//  FzVourcherInfoObject.h
//  FuzzyMark
//
//  Created by Nguyen Cuong on 8/3/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FZHomeObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface FzVourcherInfoObject : NSObject

@property (strong, nonatomic) RewardObject *voucher;
@property (assign, nonatomic) NSInteger countReceived;
@property (strong, nonatomic) NSString *intro;
@property (strong, nonatomic) NSArray *acceptedPage;
@property (strong, nonatomic) NSArray *relatedVouchers;

- (instancetype)initWithDataDictionary:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
