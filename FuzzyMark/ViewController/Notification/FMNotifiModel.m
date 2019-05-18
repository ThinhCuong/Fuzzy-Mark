//
//  FMNotifiModel.m
//  FuzzyMark
//
//  Created by Tu Tran on 5/19/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import "FMNotifiModel.h"
#import "Notifi.h"

@interface FMNotifiModel ()

@property (strong, nonatomic) NSMutableArray <Notifi*> *listItem;

@end

@implementation FMNotifiModel {
    BaseCallApi *_httpClient;
    BOOL _isLoadMore;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _httpClient = [BaseCallApi defaultInitWithBaseURL];
        self.listItem = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)actionPullToRefreshData {
    [self.listItem removeAllObjects];
    NSDictionary *params = @{@"limit": GET_USER_NOTIFICATIONS, @"offset": @0};
    [self getUserNotifications:params];
}

- (void)actionLoadMoreData {
    if(!_isLoadMore) {
        [self.delegate updateViewDataEmpty];
        return;
    }
    NSDictionary *params = @{@"limit": GET_USER_NOTIFICATIONS, @"offset": @(self.listItem.count)};
    [self getUserNotifications:params];
}

- (void)getUserNotifications:(NSDictionary *) params {
    [_httpClient getDataWithPath:GET_USER_NOTIFICATIONS andParam:params isShowfailureAlert:YES withSuccessBlock:^(id success) {
        if(success) {
            BTParseJSON *json = [[BTParseJSON alloc] initWithDict:success];
            NSInteger numberItem = [json arrayForKey:@"data"].count;
            self->_isLoadMore = numberItem >= 50;
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
