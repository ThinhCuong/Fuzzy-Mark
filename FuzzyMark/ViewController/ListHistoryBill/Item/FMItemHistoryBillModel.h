//
//  FMItemHistoryBillModel.h
//  FuzzyMark
//
//  Created by Tu Tran on 5/6/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMBaseTableViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface FMItemHistoryBillModel : FMBaseTableViewModel
- (instancetype)initWithType:(StatusType) type;
@end

NS_ASSUME_NONNULL_END
