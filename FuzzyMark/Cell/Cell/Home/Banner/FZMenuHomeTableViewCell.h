//
//  FZMenuHomeTableViewCell.h
//  FuzzyMark
//
//  Created by Nguyen Cuong on 4/15/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FZHomeJsonModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface FZMenuHomeTableViewCell : UITableViewCell

- (void)bindData:(NSArray<FZBannerModel> *)listBanner;

@end

NS_ASSUME_NONNULL_END
