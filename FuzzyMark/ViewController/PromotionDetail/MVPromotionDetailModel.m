//
//  MVPromotionDetailModel.m
//  FuzzyMark
//
//  Created by Tu Tran on 6/16/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import "MVPromotionDetailModel.h"

@implementation MVPromotionDetailModel {
    BaseCallApi *_httpClient;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _httpClient = [BaseCallApi defaultInitWithBaseURL];
    }
    return self;
}

- (void)getVouchersInfoWithIDVoucher:(NSString *) idVoucher {
    [_httpClient getDataWithPath:@"vouchers/info" andParam:@{@"id": idVoucher} isShowfailureAlert:YES withSuccessBlock:^(id success) {
        
    } withFailBlock:^(id fail) {
        
    }];
}

@end
