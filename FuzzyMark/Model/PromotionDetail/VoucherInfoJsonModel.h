//
//  VoucherInfoJsonModel.h
//  FuzzyMark
//
//  Created by Tu Tran on 6/17/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Voucher.h"
#import "Page.h"

NS_ASSUME_NONNULL_BEGIN

@interface VoucherInfoJsonModel : JSONModel

@property (nonatomic) Voucher *voucher;
@property (nonatomic) NSInteger count_received;
@property (nonatomic) NSString *intro;
@property (nonatomic) NSArray <Page> *accepted_page;
@property (nonatomic) NSArray <Voucher> *related_vouchers;

@end

NS_ASSUME_NONNULL_END
