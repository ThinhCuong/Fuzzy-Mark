//
//  RegisterPromotionCell.h
//  FuzzyMark
//
//  Created by Tu Tran on 5/20/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Voucher.h"

NS_ASSUME_NONNULL_BEGIN

@interface RegisterPromotionCell : UITableViewCell
- (void)binDataWithVoucher:(Voucher *) model;
@end

NS_ASSUME_NONNULL_END
