//
//  MVPromotionDetailModel.m
//  FuzzyMark
//
//  Created by Tu Tran on 6/16/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import "FMPromotionDetailModel.h"
#import "FzVourcherInfoObject.h"

@implementation FMPromotionDetailModel {
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

- (void)getVouchersInfoWithIDVoucher:(NSInteger) idVoucher {
    [_httpClient getDataWithPath:GET_VOUCHERS_INFO andParam:@{@"id": @(idVoucher)} isShowfailureAlert:YES withSuccessBlock:^(id success) {
        if(success) {
            if([success[@"errorCode"] integerValue] == 0) {
                FzVourcherInfoObject *voucher = [[FzVourcherInfoObject alloc] initWithDataDictionary:[success dictionaryForKey:@"data"]];
                
                [self.delegate getDataSuccess:voucher];
                
            } else {
                [self.delegate getDataError];
            }
        } else {
            [self.delegate getDataFail];
        }
    } withFailBlock:^(id fail) {
        [self.delegate getDataFail];
    }];
}

@end
