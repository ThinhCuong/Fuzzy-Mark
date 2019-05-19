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

@property (nonatomic) NSInteger idPage;
@property (nonatomic) NSString *name;
@property (nonatomic) NSString *address;
@property (nonatomic) NSInteger rate_count;
@property (nonatomic) NSInteger total_rate;
@property (nonatomic) NSString *image;
@property (nonatomic) NSString *open_time;
@property (nonatomic) NSString *close_time;
@property (nonatomic) NSString *hotline;
@property (nonatomic) NSInteger min_price;
@property (nonatomic) NSInteger max_price;

@end

NS_ASSUME_NONNULL_END
