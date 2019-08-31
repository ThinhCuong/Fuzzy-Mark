//
//  FMPageInfoRateCell.h
//  FuzzyMark
//
//  Created by Tu Tran on 8/30/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PageInfo.h"
#import <Cosmos-Swift.h>

NS_ASSUME_NONNULL_BEGIN

@interface FMPageInfoRateCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imgUser;
@property (weak, nonatomic) IBOutlet UILabel *lbTime;
@property (weak, nonatomic) IBOutlet UILabel *lbName;
@property (weak, nonatomic) IBOutlet CosmosView *rateView;
- (void)binDataWith:(RageView *) pageInfo;

@end

NS_ASSUME_NONNULL_END
