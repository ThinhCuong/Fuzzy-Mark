//
//  FZVouchersSearchModel.h
//  FuzzyMark
//
//  Created by Tu Tran on 8/25/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMVouchersObjecRequest.h"
#import "FMBaseTableViewModel.h"
#import <CoreLocation/CoreLocation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FZVouchersSearchModel : FMBaseTableViewModel <CLLocationManagerDelegate>
@property (strong, nonatomic) FMVouchersObjecRequest *objRequest;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (assign, nonatomic) CLLocationCoordinate2D coordinate;
@end

NS_ASSUME_NONNULL_END
