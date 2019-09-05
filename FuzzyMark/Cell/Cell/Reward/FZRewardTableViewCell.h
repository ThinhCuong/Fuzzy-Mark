//
//  FZRewardTableViewCell.h
//  FuzzyMark
//
//  Created by Nguyen Cuong on 8/24/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FZRewardTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UIView *backGroundView;
@property (weak, nonatomic) IBOutlet UILabel *discountLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

- (void)bindData:(Promotion *)reward;

@end

NS_ASSUME_NONNULL_END
