//
//  FZItemMenuHomeTableViewCell.h
//  FuzzyMark
//
//  Created by Nguyen Cuong on 4/15/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FZHomeObject.h"

NS_ASSUME_NONNULL_BEGIN

@protocol FZItemMenuHomeTableViewDelegate <NSObject>

- (void)didSelectChooseItemWithIDVoucher:(NSInteger )idVoucher;
- (void)didSelectSearchCategoryID:(NSInteger)categoryID;

@end

@interface FZItemMenuHomeTableViewCell : UITableViewCell

@property (assign, nonatomic) id<FZItemMenuHomeTableViewDelegate> delegate;

- (void)bindData:(GroupInfoObject *) groupInfoObject;

@end

NS_ASSUME_NONNULL_END
