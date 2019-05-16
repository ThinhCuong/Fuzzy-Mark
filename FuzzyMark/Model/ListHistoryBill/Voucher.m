//
//  Voucher.m
//  FuzzyMark
//
//  Created by Tu Tran on 5/5/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import "Voucher.h"

@implementation Voucher

+ (JSONKeyMapper *)keyMapper {
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{
                                                                  @"idVoucher": @"id", @"descriptionVoucher": @"description"
                                                                  }];
}


@end
