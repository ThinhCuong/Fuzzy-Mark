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

@property (nonatomic) NSInteger idVoucher;
@property (nonatomic) NSString *name;
@property (nonatomic) NSString *image;
@property (nonatomic) NSString <Optional> *logo;
@property (nonatomic) NSString *descriptionVoucher;
@property (nonatomic) NSNumber <Optional> *percent_discount;
@property (nonatomic) Page <Optional> *page;

@end

NS_ASSUME_NONNULL_END
