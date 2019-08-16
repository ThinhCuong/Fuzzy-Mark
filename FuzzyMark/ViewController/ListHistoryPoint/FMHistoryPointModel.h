//
//  FMHistoryPointModel.h
//  FuzzyMark
//
//  Created by Tu Tran on 5/16/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMBaseTableViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface FMHistoryPointModel : FMBaseTableViewModel
@property (strong, nonatomic) NSMutableArray *listData;
@end

NS_ASSUME_NONNULL_END
