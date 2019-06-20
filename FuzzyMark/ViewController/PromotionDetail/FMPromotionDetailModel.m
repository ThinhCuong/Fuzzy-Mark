//
//  MVPromotionDetailModel.m
//  FuzzyMark
//
//  Created by Tu Tran on 6/16/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import "FMPromotionDetailModel.h"

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

- (void)getVouchersInfoWithIDVoucher:(NSString *) idVoucher {
    [_httpClient getDataWithPath:@"vouchers/info" andParam:@{@"id": idVoucher} isShowfailureAlert:YES withSuccessBlock:^(id success) {
        if(success) {
            if([success[@"errorCode"] integerValue] == 0) {
                NSError *err;
                VoucherInfoJsonModel *vocherInfo = [[VoucherInfoJsonModel alloc] initWithDictionary:success[@"data"] error:&err];
                [self.delegate getDataSuccess:vocherInfo];
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
