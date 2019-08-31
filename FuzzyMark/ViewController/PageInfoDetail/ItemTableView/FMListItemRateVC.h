//
//  FMListItemRateVC.h
//  FuzzyMark
//
//  Created by Tu Tran on 8/30/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FMBaseListItemVC.h"
#import "FMPageInfoRateCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface FMListItemRateVC : FMBaseListItemVC
@property (weak, nonatomic) IBOutlet UILabel *lbStar;
@property (weak, nonatomic) IBOutlet UILabel *lbnumberRate;
@property (weak, nonatomic) IBOutlet UIView *statusView;
- (instancetype)initWithPageInfo:(PageInfo *) pageInfo;

@end

NS_ASSUME_NONNULL_END
