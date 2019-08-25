//
//  HistoryBillHeaderCell.h
//  FuzzyMark
//
//  Created by Tu Tran on 5/19/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HistoryBill.h"

NS_ASSUME_NONNULL_BEGIN

@class HistoryBillHeaderCell;
@protocol HistoryBillHeaderCellDelegate <NSObject>

- (void)didSelectShowDetail:(HistoryBillHeaderCell* ) cell;

@end

@interface HistoryBillHeaderCell : UITableViewHeaderFooterView
@property (assign, nonatomic) id<HistoryBillHeaderCellDelegate> delegate;
- (void)binData:(HistoryBill *) model;

@end

NS_ASSUME_NONNULL_END
