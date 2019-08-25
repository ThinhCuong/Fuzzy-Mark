//
//  FMSecondsNewsTableViewCell.h
//  FuzzyMark
//
//  Created by Tu Tran on 4/17/19.
//  Copyright © 2019 Tu Tran. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FZNewsObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface FMSecondsNewsTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *newsImage;

- (void)bindData:(FZNewsObject *)newsInfo;

@end

NS_ASSUME_NONNULL_END
