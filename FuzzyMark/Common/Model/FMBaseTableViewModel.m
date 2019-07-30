//
//  FMBaseModel.m
//  FuzzyMark
//
//  Created by Tu Tran on 5/19/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import "FMBaseTableViewModel.h"

@implementation FMBaseTableViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.httpClient = [BaseCallApi defaultInitWithBaseURL];
        self.listItem = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)actionPullToRefreshData {
    [self.listItem removeAllObjects];
    NSDictionary *params = @{@"limit": GET_USER_NOTIFICATIONS, @"offset": @0};
    [self getDataTableView:params.mutableCopy];
}

- (void)actionLoadMoreData {
    if(!_isLoadMore) {
        [self.delegate updateViewDataEmpty];
        return;
    }
    NSDictionary *params = @{@"limit": GET_USER_NOTIFICATIONS, @"offset": @(self.listItem.count)};
    [self getDataTableView:params.mutableCopy];
}

- (void)getDataTableView:(NSMutableDictionary *) params {
    
}

@end
