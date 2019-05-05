//
//  Page.h
//  FuzzyMark
//
//  Created by Tu Tran on 5/5/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Location.h"

NS_ASSUME_NONNULL_BEGIN

@interface Page : JSONModel

@property (strong, nonatomic) NSNumber <Optional> *id;
@property (strong, nonatomic) NSString <Optional> *name;
@property (strong, nonatomic) Location <Optional> *location;
@property (strong, nonatomic) NSString <Optional> *address;
@property (strong, nonatomic) NSNumber <Optional> *rate_count;
@property (strong, nonatomic) NSNumber <Optional> *total_rate;
@property (strong, nonatomic) NSString <Optional> *image;
@property (strong, nonatomic) NSString <Optional> *open_time;
@property (strong, nonatomic) NSString <Optional> *close_time;
@property (strong, nonatomic) NSString <Optional> *hotline;
@property (strong, nonatomic) NSNumber <Optional> *min_price;
@property (strong, nonatomic) NSNumber <Optional> *max_price;

@end

NS_ASSUME_NONNULL_END
