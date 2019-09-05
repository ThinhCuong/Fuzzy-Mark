//
//  FMLocationFavoriteModel.m
//  FuzzyMark
//
//  Created by Tu Tran on 7/30/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import "FMLocationFavoriteModel.h"
#import "FZHomeModel.h"

@implementation FMLocationFavoriteModel

- (void)getDataTableView:(NSMutableDictionary *) params {
    [self.httpClient getDataWithPath:GET_PAGES_INTERESTED andParam:params isShowfailureAlert:YES withSuccessBlock:^(id success) {
        if([success isKindOfClass:[NSDictionary class]]) {
            NSInteger numberItem = [success arrayForKey:@"data"].count;
            self.isLoadMore = numberItem >= 50;
            if(numberItem > 0) {
                for (NSDictionary *dict in [success arrayForKey:@"data"]) {
                    PageObject *page = [[PageObject alloc] initWithDataDictionary:dict];
                    [self.listItem addObject:page];
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
