//
//  FMHistoryPointModel.m
//  FuzzyMark
//
//  Created by Tu Tran on 5/16/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import "FMHistoryPointModel.h"

@implementation FMHistoryPointModel {
    BaseCallApi *_httpClient;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _httpClient = [BaseCallApi defaultInitWithBaseURL];
        self.listData = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)getListHistoryCaptureWithSuccessBlock: (void(^)(id)) successBlock {
//    NSDictionary *param = @{@"limit": @"50", @"offset": @(self.listData.count)};
//
//    [[BaseCallApi defaultInitWithBaseURL] getDataWithPath:GET_HISTORIES_CAPTURE andParam:param isShowfailureAlert:YES withSuccessBlock:^(id success) {
//        if(success) {
//            BTParseJSON *json = [[BTParseJSON alloc] initWithDict:success];
//            if([json arrayForKey:@"data"]) {
//                NSArray *data = [json arrayForKey:@"data"];
//                if(data.count > 0 && data) {
//                    for (NSDictionary *dict in data) {
//                        HistoryBill *item = [[HistoryBill alloc] initWithDictionary:dict error:nil];
//                        [self.listData addObject:item];
//                    }
//                }
//            }
//            successBlock(self.listData);
//        } else {
//            successBlock(nil);
//        }
//    } withFailBlock:^(id fail) {
//        successBlock(nil);
//    }];
}

@end
