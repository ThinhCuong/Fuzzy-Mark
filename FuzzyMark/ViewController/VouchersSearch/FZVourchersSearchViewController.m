//
//  FZVourchersSearchViewController.m
//  FuzzyMark
//
//  Created by Nguyen Cuong on 6/13/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import "FZVourchersSearchViewController.h"
#import "FZVourcherSearchTableViewCell.h"
#import "FZHomeModel.h"
#import "FMPromotionDetailVC.h"
#import "LocationFavoriteTableViewCell.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface FZVourchersSearchViewController ()<UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate> {
    CLLocationManager *_locationManager;
    CLLocationCoordinate2D _coordinate;
}
@property (strong, nonatomic) NSArray <RewardObject *> *listVourcher;

@end

@implementation FZVourchersSearchViewController {
    NSString *_keyWord;
}

- (instancetype)initWithKeyWord:(NSString *)keyWord
{
    self = [super init];
    if (self) {
        _keyWord = keyWord;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.tableView registerNib:[UINib nibWithNibName:@"LocationFavoriteTableViewCell" bundle:nil] forCellReuseIdentifier:@"LocationFavoriteTableViewCell"];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self callVouchersSearch];
    
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.delegate = self;

    _locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers;
    if([_locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]){
        [_locationManager requestWhenInUseAuthorization];
    }else{
        [_locationManager startUpdatingLocation];
    }
}

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


- (IBAction)backToParentViewController:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listVourcher.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LocationFavoriteTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LocationFavoriteTableViewCell"];
    [cell bindData:self.listVourcher[indexPath.row] currentLocation:_coordinate];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    RewardObject *reward = self.listVourcher[indexPath.row];
    NSString *voucherID = [NSString stringWithFormat:@"%ld", (long)reward.rewardId];
    FMPromotionDetailVC *vc = [[FMPromotionDetailVC alloc] initWithIDVoucher:voucherID];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)callVouchersSearch {
    
    NSDictionary *params = @{
                             @"token": [UserInfo getUserToken] ?: @"",
                             @"limit": @"50",
                             @"offset" : @(_listVourcher.count),
                             @"keyword" : _keyWord ?: @"",
                             @"lat" : @"20.9813266",
                             @"lng" : @"105.7874813",
                             @"categories" : @"",
                             @"services" : @""
                             };
    
    [SVProgressHUD setContainerView:self.view];
    [SVProgressHUD show];
    [[BaseCallApi defaultInitWithBaseURL] getDataWithPath:@"vouchers/search" andParam:params isShowfailureAlert:YES withSuccessBlock:^(id responseData) {
        [SVProgressHUD dismiss];
        if (responseData) {
            NSMutableArray *listData = [NSMutableArray new];
            NSArray *data = [responseData arrayForKey:@"data"];
            for (NSDictionary *dict in data) {
                RewardObject *obj = [[RewardObject alloc] initWithDataDictionary:dict];
                [listData addObject:obj];
            }
            self.listVourcher = listData;
            [self.tableView reloadData];
        }
    } withFailBlock:^(id responseError) {
        [SVProgressHUD dismiss];
    }];
}

@end
