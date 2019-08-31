//
//  MVPromotionIntroCell.h
//  FuzzyMark
//
//  Created by Tu Tran on 6/19/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FzVourcherInfoObject.h"
#import "PageInfo.h"

NS_ASSUME_NONNULL_BEGIN

@interface FMPromotionIntroCell : UITableViewCell

- (void)binData:(FzVourcherInfoObject *) model;
- (void)binDataWithPageInfo:(PageInfo *)model;

@end

NS_ASSUME_NONNULL_END
