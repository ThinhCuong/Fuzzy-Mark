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

@protocol LocationFavoriteTableViewCell <NSObject>

- (void)showDetailPageWithID:(NSInteger) idPage;

@end

@interface LocationFavoriteTableViewCell : UITableViewCell

@property (assign, nonatomic) id<LocationFavoriteTableViewCell>delegate;

- (void)bindData:(RewardObject *)groupInfo currentLocation:(CLLocationCoordinate2D)currentLocation;

@end

NS_ASSUME_NONNULL_END
