//
//  FZMenuHomeCollectionViewCell.h
//  FuzzyMark
//
//  Created by Nguyen Cuong on 4/18/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FZHomeJsonModel.h"
#import "FZHomeObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface FZMenuHomeCollectionViewCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UIImageView *groupImage;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *groupInfoDescriptionLabel;
@property (strong, nonatomic) IBOutlet UILabel *percenDiscountLabel;


- (void)bindData:(RewardObject *)groupInfo;

@end

NS_ASSUME_NONNULL_END
