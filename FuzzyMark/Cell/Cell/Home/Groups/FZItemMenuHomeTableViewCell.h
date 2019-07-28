//
//  FZItemMenuHomeTableViewCell.h
//  FuzzyMark
//
//  Created by Nguyen Cuong on 4/15/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FZHomeJsonModel.h"
#import "FZHomeObject.h"

NS_ASSUME_NONNULL_BEGIN

@protocol FZItemMenuHomeTableViewDelegate <NSObject>

- (void)didSelectChooseItemWithIDVoucher:(NSString *) idVoucher;

@end

@interface FZItemMenuHomeTableViewCell : UITableViewCell

@property (assign, nonatomic) id<FZItemMenuHomeTableViewDelegate> delegate;
- (void)bindData:(NSArray<RewardObject *> *)listVoucherVertical listVoucherHorizontal:(NSArray<RewardObject *> *)listVoucherHorizontal;

@end

NS_ASSUME_NONNULL_END
