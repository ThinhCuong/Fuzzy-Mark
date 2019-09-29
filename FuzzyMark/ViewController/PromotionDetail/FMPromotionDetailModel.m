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
    NSDictionary *param = @{@"id": @(idVoucher)};
    [_httpClient getDataWithPath:GET_VOUCHERS_INFO andParam:param isShowfailureAlert:YES withSuccessBlock:^(id success) {
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

- (void)addVoucherInterested:(NSInteger) idVoucher withComplete:(void (^) (BOOL)) completion {
    NSDictionary *param = @{@"id": @(idVoucher)};
    [_httpClient postDataWithPath:POST_VOUCHERS_ADD_INTERESTED andParam:param isSendToken:YES isShowfailureAlert:YES withSuccessBlock:nil withFailBlock:nil];
    [_httpClient postDataWithPath:POST_VOUCHERS_ADD_INTERESTED andParam:param isShowfailureAlert:YES withSuccessBlock:^(id _Nullable success) {
        if(success) {
            if([success[@"errorCode"] integerValue] == 0) {
                completion?completion(YES):0;
            } else {
                completion?completion(NO):0;
            }
        } else {
            completion?completion(NO):0;
        }
    } withFailBlock:^(id _Nullable fail) {
        completion?completion(NO):0;
    }];
}

@end
