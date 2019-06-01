//
//  FMRegisterPromotionsModel.m
//  FuzzyMark
//
//  Created by Tu Tran on 5/4/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import "FMRegisterPromotionsModel.h"
#import "RegisterPromotion.h"

@implementation FMRegisterPromotionsModel {
    BaseCallApi *_httpClient;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _httpClient = [[BaseCallApi alloc] initWithBaseURL];
        self.listData = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)getListHistoryCaptureWithSuccessBlock: (void(^)(id)) successBlock {
    NSDictionary *param = @{@"limit": @"50", @"offset": @(self.listData.count)};
    [_httpClient getDataWithPath:GET_HISTORIES_CAPTURE andParam:param isShowfailureAlert:YES withSuccessBlock:^(id success) {
        if(success) {
            BTParseJSON *json = [[BTParseJSON alloc] initWithDict:success];
            if([json arrayForKey:@"data"]) {
                NSArray *data = [json arrayForKey:@"data"];
                if(data.count > 0 && data) {
                    for (NSDictionary *dict in data) {
                        RegisterPromotion *item = [[RegisterPromotion alloc] initWithDictionary:dict error:nil];
                        [self.listData addObject:item];
                    }
                }
            }
            successBlock(self.listData);
        } else {
            successBlock(nil);
        }
    } withFailBlock:^(id fail) {
        successBlock(nil);
    }];
}

@end