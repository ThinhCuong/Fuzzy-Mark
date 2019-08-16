//
//  FMHistoryPointModel.m
//  FuzzyMark
//
//  Created by Tu Tran on 5/16/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import "FMHistoryPointModel.h"
#import "HistoryCaptureObject.h"

@implementation FMHistoryPointModel

- (void)getDataTableView:(NSMutableDictionary *) params {
    [self.httpClient getDataWithPath:GET_HISTORIES_REWARD andParam:params isShowfailureAlert:YES withSuccessBlock:^(id success) {
        if([success isKindOfClass:[NSDictionary class]]) {
            if ([success codeForKey:@"error_code"] != 0) {
                [CommonFunction showToast:[success stringForKey:@"message"]];
            }
            NSInteger numberItem = [success arrayForKey:@"data"].count;
            self.isLoadMore = numberItem >= 50;
            if(numberItem > 0) {
                for (NSDictionary *dict in [success arrayForKey:@"data"]) {
                    HistoryCaptureObject *obj = [[HistoryCaptureObject alloc] initWithDataDictionary:dict];
                    [self.listData addObject:obj];
                }
                [self.delegate updateViewDataSuccess:self.listItem];
            } else {
                [self.delegate updateViewDataEmpty];
            }
        } else {
            [self.delegate updateViewDataError];
        }
        
    } withFailBlock:^(id fail) {
        [self.delegate updateViewDataError];
    }];
}

@end
