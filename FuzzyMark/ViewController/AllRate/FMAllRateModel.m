//
//  FMAllRateModel.m
//  FuzzyMark
//
//  Created by Tu Tran on 9/23/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import "FMAllRateModel.h"

@implementation FMAllRateModel

- (void)getDataTableView:(NSMutableDictionary *) params {
    [params setObject:self.pageID?:@"" forKey:@"id"];
    [self.httpClient getDataWithPath:GET_PAGES_RATES_PAGE andParam:params isSendToken:YES isShowfailureAlert:YES withSuccessBlock:^(id _Nullable success) {
        if([success isKindOfClass:[NSDictionary class]]) {
            if ([success codeForKey:@"error_code"] != 0) {
                [CommonFunction showToast:[success stringForKey:@"message"]];
            }
            NSInteger numberItem = [success arrayForKey:@"data"].count;
            self.isLoadMore = numberItem >= 50;
            if(numberItem > 0) {
                for (NSDictionary *dict in [success arrayForKey:@"data"]) {
                    RageView *obj = [[RageView alloc] initWithDataDictionary:dict];
                    [self.listItem addObject:obj];
                }
                [self.delegate updateViewDataSuccess:self.listItem];
            } else {
                [self.delegate updateViewDataEmpty];
            }
        } else {
            [self.delegate updateViewDataError];
        }
    } withFailBlock:^(id _Nullable fail) {
        [self.delegate updateViewDataError];
    }];
}

@end
