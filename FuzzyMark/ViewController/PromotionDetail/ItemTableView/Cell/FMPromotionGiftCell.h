//
//  FMPromotionGift.h
//  FuzzyMark
//
//  Created by Tu Tran on 6/19/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Voucher.h"

NS_ASSUME_NONNULL_BEGIN

@interface FMPromotionGiftCell : UITableViewCell

- (void)binData:(Voucher *) model;

@end

NS_ASSUME_NONNULL_END
