//
//  Voucher.h
//  FuzzyMark
//
//  Created by Tu Tran on 5/5/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Page.h"

NS_ASSUME_NONNULL_BEGIN

@interface Voucher : JSONModel

@property (strong, nonatomic) NSNumber <Optional> *id;
@property (strong, nonatomic) NSString <Optional> *name;
@property (strong, nonatomic) NSString <Optional> *image;
@property (strong, nonatomic) NSString <Optional> *logo;
@property (strong, nonatomic) NSString <Optional> *descriptions;
@property (strong, nonatomic) NSNumber <Optional> *percent_discount;
@property (strong, nonatomic) Page <Optional> *page;

@end

NS_ASSUME_NONNULL_END
