//
//  FZItemMenuHomeTableViewCell.h
//  FuzzyMark
//
//  Created by Nguyen Cuong on 4/15/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FZHomeJsonModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol FZItemMenuHomeTableViewDelegate <NSObject>

- (void)didSelectChooseItemWithIDVoucher:(NSString *) idVoucher;

@end

@interface FZItemMenuHomeTableViewCell : UITableViewCell

@property (assign, nonatomic) id<FZItemMenuHomeTableViewDelegate> delegate;
- (void)bindData:(NSArray<FZGroupInfoJsonModel> *)listVoucherVertical listVoucherHorizontal:(NSArray<FZGroupInfoJsonModel> *)listVoucherHorizontal;

@end

NS_ASSUME_NONNULL_END
