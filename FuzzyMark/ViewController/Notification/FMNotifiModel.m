//
//  FMNotifiModel.m
//  FuzzyMark
//
//  Created by Tu Tran on 5/19/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import "FMNotifiModel.h"
#import "Notifi.h"

@implementation FMNotifiModel

- (void)getDataTableView:(NSDictionary *) params {
    [self.httpClient getDataWithPath:GET_USER_NOTIFICATIONS andParam:params isShowfailureAlert:YES withSuccessBlock:^(id success) {
        if(success) {
            BTParseJSON *json = [[BTParseJSON alloc] initWithDict:success];
            NSInteger numberItem = [json arrayForKey:@"data"].count;
            self.isLoadMore = numberItem >= 50;
            if(numberItem > 0) {
                for (NSDictionary *dict in [json arrayForKey:@"data"]) {
                    NSError *err;
                    Notifi *noti = [[Notifi alloc] initWithDictionary:dict error:&err];
                    [self.listItem addObject:noti];
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

- (void)putUserNotifiRead:(NSDictionary *) prams {
    [self.httpClient putDataWithPath:PUT_USER_NOTIFICATIONS_READ andParam:prams isSendToken:YES isShowfailureAlert:YES withSuccessBlock:^(id success) {
        if(success) {
            if([success[@"error_code"] integerValue] == 0) {
                for (Notifi *item in self.listItem) {
                    if(item.idNoti == [prams[@"id"] integerValue]) {
                        item.is_read = YES;
                        break;
                    }
                }
                [self.delegate updateViewDataSuccess:self.listItem];
            }
        }
    } withFailBlock:^(id fail) {
        
    }];
}

- (void)putUserNotifiReadAll {
    [self.httpClient putDataWithPath:PUT_USER_NOTIFICATIONS_READ_ALL andParam:@{} isSendToken:YES isShowfailureAlert:YES withSuccessBlock:^(id success) {
        if(success) {
            if([success[@"error_code"] integerValue] == 0) {
                for (Notifi *item in self.listItem) {
                    if(!item.is_read) {
                        item.is_read = YES;
                    }
                }
                [self.delegate updateViewDataSuccess:self.listItem];
            }
        }
    } withFailBlock:^(id fail) {
        
    }];
}

@end
