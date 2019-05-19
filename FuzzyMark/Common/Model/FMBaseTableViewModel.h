//
//  FMBaseModel.h
//  FuzzyMark
//
//  Created by Tu Tran on 5/19/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMUpdateTableDataProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface FMBaseTableViewModel : NSObject

@property (assign, nonatomic) id<FMUpdateTableDataProtocol> delegate;
@property (strong, nonatomic) NSMutableArray *listItem;
@property (strong, nonatomic) BaseCallApi *httpClient;
@property (assign, nonatomic) BOOL isLoadMore;

- (void)actionLoadMoreData;
- (void)actionPullToRefreshData;

@end

NS_ASSUME_NONNULL_END
