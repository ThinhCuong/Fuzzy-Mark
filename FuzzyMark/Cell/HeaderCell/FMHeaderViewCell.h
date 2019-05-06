//
//  HistoryBillHeaderCell.h
//  FuzzyMark
//
//  Created by Tu Tran on 5/6/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@interface FMHeaderViewCell : UIView
- (void)binDataHistoryBill:(NSString *) code;
- (void)binDataRegisterPromotion:(NSString *) time;

@end

NS_ASSUME_NONNULL_END
