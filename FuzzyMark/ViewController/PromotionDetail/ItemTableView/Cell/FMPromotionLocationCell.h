//
//  MVPromotionLocationCell.h
//  FuzzyMark
//
//  Created by Tu Tran on 6/19/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Page.h"

NS_ASSUME_NONNULL_BEGIN

@interface FMPromotionLocationCell : UITableViewCell

- (void)binData:(Page *) model;

@end

NS_ASSUME_NONNULL_END