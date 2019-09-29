//
//  FMAllRateCell.h
//  FuzzyMark
//
//  Created by Tu Tran on 9/24/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PageInfo.h"

NS_ASSUME_NONNULL_BEGIN

@interface FMAllRateCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imgAvatar;
@property (weak, nonatomic) IBOutlet UILabel *lbName;
@property (weak, nonatomic) IBOutlet UILabel *lbTime;
@property (weak, nonatomic) IBOutlet UILabel *lbComment;

- (void)binData:(RageView *) model;

@end

NS_ASSUME_NONNULL_END
