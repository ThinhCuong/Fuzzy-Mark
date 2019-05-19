//
//  HistoryBillFooterCell.h
//  FuzzyMark
//
//  Created by Tu Tran on 5/6/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HistoryBill.h"

NS_ASSUME_NONNULL_BEGIN

@interface HistoryBillFooterCell : UITableViewHeaderFooterView

- (void)binData:(HistoryBill *)model;

@end

NS_ASSUME_NONNULL_END
