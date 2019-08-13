//
//  FZVourcherSearchTableViewCell.h
//  FuzzyMark
//
//  Created by Nguyen Cuong on 6/14/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FZHomeObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface FZVourcherSearchTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *discountLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalRateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *startImage;
@property (weak, nonatomic) IBOutlet UILabel *totalRateCountLabel;

- (void)bindData:(RewardObject *)groupInfo;

@end

NS_ASSUME_NONNULL_END
