//
//  FMNewsModel.m
//  FuzzyMark
//
//  Created by Tu Tran on 9/7/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import "FMNewsModel.h"
#import "FZNewsObject.h"

@implementation FMNewsModel

- (void)getDataTableView:(NSMutableDictionary *) params {
    [self.httpClient getDataWithPath:GET_NEWS_GET_NEWS andParam:params isSendToken:YES isShowfailureAlert:YES withSuccessBlock:^(id _Nullable success) {
        if([success isKindOfClass:[NSDictionary class]]) {
            if ([success codeForKey:@"error_code"] != 0) {
                [CommonFunction showToast:[success stringForKey:@"message"]];
            }
            NSInteger numberItem = [success arrayForKey:@"data"].count;
            self.isLoadMore = numberItem >= 50;
            if(numberItem > 0) {
                for (NSDictionary *dict in [success arrayForKey:@"data"]) {
                    FZNewsObject *obj = [[FZNewsObject alloc] initWithDataDictionary:dict];
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
