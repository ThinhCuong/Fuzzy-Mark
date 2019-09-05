//
//  FZHomeViewController.h
//  FuzzyMark
//
//  Created by Nguyen Cuong on 4/14/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FZHomeModel.h"
#import "FZHomeHeaderView.h"
#import "BaseCallApi.h"
#import "FMPromotionDetailVC.h"
#import "FZMenuHomeTableViewCell.h"
#import "FZItemMenuHomeTableViewCell.h"
#import "FZVourchersSearchViewController.h"
#import "FZHotlineViewController.h"
#import "FZHomeObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface FZHomeViewController : FMBaseViewController <UITableViewDataSource, UITableViewDelegate, FZHomeHeaderDelegate, FZMenuHomeTableViewCellDelegate, FZItemMenuHomeTableViewDelegate, FZHomeHeaderDelegate>

@end

NS_ASSUME_NONNULL_END
