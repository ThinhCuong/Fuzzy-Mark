//
//  FZItemMenuVerticalTableViewCell.h
//  FuzzyMark
//
//  Created by Nguyen Cuong on 5/5/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FZHomeObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface FZItemMenuVerticalTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *image;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *groupInfoDescriptionLabel;
@property (strong, nonatomic) IBOutlet UILabel *percenDiscountLabel;

- (void)bindData:(RewardObject *)groupInfo;

@end

NS_ASSUME_NONNULL_END
