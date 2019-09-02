//
//  FZVouchersSearchModel.m
//  FuzzyMark
//
//  Created by Tu Tran on 8/25/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import "FZVouchersSearchModel.h"
#import "FZHomeModel.h"



@implementation FZVouchersSearchModel {
    NSInteger _categories;
    NSArray *_services;
    NSInteger _lat;
    NSInteger _lng;
    NSString *_keyword;
}

#pragma mark - life cycle
- (instancetype)init
{
    self = [super init];
    if (self) {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
        
        _locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers;
        if([_locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]){
            [_locationManager requestWhenInUseAuthorization];
        }else{
            [_locationManager startUpdatingLocation];
        }
    }
    return self;
}

#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    if (status == kCLAuthorizationStatusAuthorizedWhenInUse || status == kCLAuthorizationStatusAuthorizedAlways) {
        [_locationManager startUpdatingLocation];
        _coordinate = [[_locationManager location] coordinate];
    } else if (status == kCLAuthorizationStatusDenied) {
        [CommonFunction showToast:@"Bạn cần vào cài đặt cấp quyền vị trí cho ứng dụng"];
    } else if (status == kCLAuthorizationStatusNotDetermined) {
        if ([manager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
            [manager requestWhenInUseAuthorization];
            [_locationManager startUpdatingLocation];
        }
    }
}

#pragma mark - private
- (void)getDataTableView:(NSMutableDictionary *) params {
    NSDictionary *newParams = [self addDataParams:params];
    [self.httpClient getDataWithPath:GET_VOUCHERS_SEARCH andParam:newParams isSendToken:YES isShowfailureAlert:YES withSuccessBlock:^(id _Nullable success) {
        if([success isKindOfClass:[NSDictionary class]]) {
            if ([success codeForKey:@"error_code"] != 0) {
                [CommonFunction showToast:[success stringForKey:@"message"]];
            }
            NSInteger numberItem = [success arrayForKey:@"data"].count;
            self.isLoadMore = numberItem >= 50;
            if(numberItem > 0) {
                for (NSDictionary *dict in [success arrayForKey:@"data"]) {
                    RewardObject *obj = [[RewardObject alloc] initWithDataDictionary:dict];
                    [self.listItem addObject:obj];
                }
                [self.delegate updateViewDataSuccess:self.listItem];
            } else {
                [self.delegate updateViewDataEmpty];
            }
        } else {
            [self.delegate updateViewDataError];
        }
    } withFailBlock:^(id _Nullable fail) {
        [self.delegate updateViewDataError];
    }];
}

- (NSDictionary *)addDataParams:(NSMutableDictionary *) params {
    NSMutableDictionary *newParam = [_objRequest getParamRequestWithLocation:_coordinate].mutableCopy;
    [newParam addEntriesFromDictionary:params];
    return newParam.copy;
}

@end
