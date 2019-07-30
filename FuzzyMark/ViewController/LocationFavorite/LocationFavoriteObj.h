//
//  LocationFavoriteObj.h
//  FuzzyMark
//
//  Created by Tu Tran on 7/30/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Location.h"

NS_ASSUME_NONNULL_BEGIN

@interface LocationFavoriteObj : NSObject

@property (assign, nonatomic) NSInteger idLocation;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) Location *location;
@property (strong, nonatomic) NSString *address;
@property (assign, nonatomic) NSInteger rate_count;
@property (assign, nonatomic) NSInteger total_rate;
@property (strong, nonatomic) NSString *image;
@property (assign, nonatomic) NSString *open_time;
@property (strong, nonatomic) NSString *close_time;
@property (strong, nonatomic) NSString *hotline;
@property (strong, nonatomic) NSString *range_price;
@property (assign, nonatomic) NSInteger discount;

@end

NS_ASSUME_NONNULL_END
