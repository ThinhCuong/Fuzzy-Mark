//
//  LocationFavoriteTableViewCell.h
//  FuzzyMark
//
//  Created by Tu Tran on 5/17/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FZHomeObject.h"
#import <CoreLocation/CoreLocation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LocationFavoriteTableViewCell : UITableViewCell

- (void)bindData:(RewardObject *)groupInfo currentLocation:(CLLocationCoordinate2D)currentLocation;

@end

NS_ASSUME_NONNULL_END
