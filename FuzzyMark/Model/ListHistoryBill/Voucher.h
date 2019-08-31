//
//  Voucher.h
//  FuzzyMark
//
//  Created by Tu Tran on 5/5/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FZHomeObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface Voucher : NSObject

@property (nonatomic) NSInteger idVoucher;
@property (nonatomic) NSString *name;
@property (nonatomic) NSString *image;
@property (nonatomic) NSString *logo;
@property (nonatomic) NSString *descriptionVoucher;
@property (nonatomic) NSInteger percent_discount;
@property (nonatomic) PageObject *page;
@property (nonatomic) NSInteger count_down;
@property (nonatomic) NSString *time_bookmark;
- (instancetype)initWithDataDictionary:(NSDictionary *)data;

@end

NS_ASSUME_NONNULL_END
