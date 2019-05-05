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
    NSMutableArray *_listData;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _httpClient = [[BaseCallApi alloc] initWithBaseURL];
        _listData = [[NSMutableArray alloc] init];
        [self getListHistoryCapture];
    }
    return self;
}

- (void)getListHistoryCapture {
    NSDictionary *param = @{@"limit": @"50", @"offset": @(_listData.count)};
    [_httpClient getDataWithPath:GET_HISTORIES_CAPTURE andParam:param isShowfailureAlert:YES withSuccessBlock:^(id success) {
        if(success) {
            BTParseJSON *json = [[BTParseJSON alloc] initWithDict:success];
            if([json arrayForKey:@"data"]) {
                NSArray *data = [json arrayForKey:@"data"];
                if(data.count > 0 && data) {
                    for (NSDictionary *dict in data) {
                        RegisterPromotion *item = [[RegisterPromotion alloc] initWithDictionary:dict error:nil];
                        [self->_listData addObject:item];
                    }
                }
            }
        }
    } withFailBlock:^(id fail) {
        
    }];
}

@end
