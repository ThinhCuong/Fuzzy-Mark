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
#import "FZVouchersSearchModel.h"
#import <CCBottomRefreshControl-umbrella.h>

@interface FZVourchersSearchViewController ()<UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate, FMUpdateTableDataProtocol> {
    CLLocationManager *_locationManager;
    CLLocationCoordinate2D _coordinate;
}

@property (strong, nonatomic) FZVouchersSearchModel *model;

@end

@implementation FZVourchersSearchViewController {
    NSString *_keyWord;
    NSMutableArray <NSNumber *> *_categories;
    NSMutableArray <NSNumber *> *_services;
    NSArray <RewardObject *> *_listVourcher;
    UIRefreshControl *_topRFControl;
    UIRefreshControl *_bottomRFControl;
    BOOL _isRefresh;

}

- (instancetype)initWithKeyWord:(NSString *)keyWord
{
    self = [super init];
    if (self) {
        _keyWord = keyWord;
        self.model = [[FZVouchersSearchModel alloc] init];
        self.model.delegate = self;
    }
    return self;
}

- (instancetype)initWithCategori:(NSInteger)categori
{
    self = [super init];
    if (self) {
        NSNumber *categoriNumber = [NSNumber numberWithInteger:categori];
        [_categories addObject:categoriNumber];
        self.model = [[FZVouchersSearchModel alloc] init];
        self.model.delegate = self;
    }
    return self;
}

- (instancetype)initWithService:(NSInteger)service
{
    self = [super init];
    if (self) {
        NSNumber *serviceNumber = [NSNumber numberWithInteger:service];
        [_services addObject:serviceNumber];
        self.model = [[FZVouchersSearchModel alloc] init];
        self.model.delegate = self;
    }
    return self;
}

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setTableViewContent];
    [self setLocationManager];
    [self callDataRefresh];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if(_isRefresh) {
        [CommonFunction showLoadingView];
    }
}


#pragma mark - private
- (void)setTableViewContent {
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"LocationFavoriteTableViewCell" bundle:nil] forCellReuseIdentifier:@"LocationFavoriteTableViewCell"];
    
    _topRFControl = [[UIRefreshControl alloc] init];
    [_topRFControl addTarget:self action:@selector(callDataRefresh) forControlEvents:UIControlEventValueChanged];
    if (@available(iOS 10.0, *)) {
        self.tableView.refreshControl = _topRFControl;
    } else {
        [self.tableView addSubview:_topRFControl];
    }
    
    _bottomRFControl = [UIRefreshControl new];
    [_bottomRFControl addTarget:self action:@selector(callDataLoadMore) forControlEvents:UIControlEventValueChanged];
    self.tableView.bottomRefreshControl = _bottomRFControl;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 20, 0);
}

- (void)setLocationManager {
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.delegate = self;
    
    _locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers;
    if([_locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]){
        [_locationManager requestWhenInUseAuthorization];
    }else{
        [_locationManager startUpdatingLocation];
    }
}

- (void)callDataLoadMore {
    if([self checkIsRefresh]) {
        [self stopAnimationRefresh];
        return;
    }
    _isRefresh = YES;
    [self saveDataModelBeforeRequest];
    [self.model actionLoadMoreData];
}

- (void)callDataRefresh {
    if([self checkIsRefresh]) {
        [self stopAnimationRefresh];
        return;
    }
    _isRefresh = YES;
    [self saveDataModelBeforeRequest];
    [self.model actionPullToRefreshData];
}

- (BOOL)checkIsRefresh {
    return _isRefresh;
}

- (void)saveDataModelBeforeRequest {
    FZUploadDataVoucher *dataUpload = [FZUploadDataVoucher new];
    dataUpload.keyword = _keyWord;
    dataUpload.categories = _categories;
    dataUpload.service = _services;
    dataUpload.lat = _coordinate.latitude;
    dataUpload.lng = _coordinate.longitude;
}

- (void)stopAnimationRefresh {
    if(_topRFControl.isRefreshing) {
        [_topRFControl endRefreshing];
    }
    if(_bottomRFControl.isRefreshing) {
        [_bottomRFControl endRefreshing];
    }
    [CommonFunction hideLoadingView];
    _isRefresh = NO;
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

#pragma mark - FMUpdateDataProtocol
- (void)updateViewDataSuccess:(NSMutableArray *) listData {
    [self stopAnimationRefresh];
    _listVourcher = listData.copy;
    [self.tableView reloadData];
}

- (void)updateViewDataEmpty {
    [self stopAnimationRefresh];
}

- (void)updateViewDataError {
    [self stopAnimationRefresh];
}

#pragma mark - IBAction
- (IBAction)backToParentViewController:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _listVourcher.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LocationFavoriteTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LocationFavoriteTableViewCell"];
    [cell bindData:_listVourcher[indexPath.row] currentLocation:_coordinate];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    RewardObject *reward = _listVourcher[indexPath.row];
    FMPromotionDetailVC *vc = [[FMPromotionDetailVC alloc] initWithIDVoucher:reward.rewardId];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
