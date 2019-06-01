//
//  FMUpdateDataProtocol.h
//  FuzzyMark
//
//  Created by Tu Tran on 5/19/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol FMUpdateTableDataProtocol <NSObject>

- (void)updateViewDataSuccess:(NSArray *) listData;
- (void)updateViewDataEmpty;
- (void)updateViewDataError;

@end

NS_ASSUME_NONNULL_END
