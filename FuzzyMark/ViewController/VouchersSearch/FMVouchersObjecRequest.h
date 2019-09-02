//
//  FMVouchersObjecRequest.h
//  FuzzyMark
//
//  Created by Tu Tran on 9/2/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FMVouchersObjecRequest : NSObject

@property (strong, nonatomic) NSString *keyword;
@property (strong, nonatomic) NSArray <NSNumber*> *categoriesID;
@property (strong, nonatomic) NSArray <NSNumber*> *servicesID;
- (void)addCategoryID:(NSInteger) categoryID;
- (void)removeCategoryID:(NSInteger) categoryID;
- (void)addSeviceID:(NSInteger) serviceID;
- (void)removeSeviceID:(NSInteger) serviceID;
- (NSDictionary *)getParamRequestWithLocation:(CLLocationCoordinate2D)currentLocation;

@end

NS_ASSUME_NONNULL_END
