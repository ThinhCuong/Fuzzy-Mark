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

- (void)getUserNotifications:(NSDictionary *) params {
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

@end
