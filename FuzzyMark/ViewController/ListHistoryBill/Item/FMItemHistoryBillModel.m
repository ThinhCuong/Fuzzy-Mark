//
//  FMItemHistoryBillModel.m
//  FuzzyMark
//
//  Created by Tu Tran on 5/6/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import "FMItemHistoryBillModel.h"
#import "HistoryBill.h"

@implementation FMItemHistoryBillModel {
    StatusType _type;
}

- (instancetype)initWithType:(StatusType) type
{
    self = [super init];
    if (self) {
        _type = type;
    }
    return self;
}

- (void)getDataTableView:(NSMutableDictionary *) params {
    [params setObject:@(_type) forKey:@"status"];
    [self.httpClient getDataWithPath:GET_HISTORIES_CAPTURE andParam:params isSendToken:YES isShowfailureAlert:YES withSuccessBlock:^(id _Nullable success) {
        if([success isKindOfClass:[NSDictionary class]]) {
            if ([success codeForKey:@"error_code"] != 0) {
                [CommonFunction showToast:[success stringForKey:@"message"]];
            }
            NSInteger numberItem = [success arrayForKey:@"data"].count;
            self.isLoadMore = numberItem >= 50;
            if(numberItem > 0) {
                for (NSDictionary *dict in [success arrayForKey:@"data"]) {
                    HistoryBill *bill = [[HistoryBill alloc] initWithDataDictionary:dict];
                    [self.listItem addObject:bill];
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
