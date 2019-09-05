//
//  LocationFavoriteViewController.m
//  FuzzyMark
//
//  Created by Tu Tran on 5/16/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import "FMLocationFavoriteViewController.h"
#import "LocationFavoriteTableViewCell.h"
#import "FMLocationFavoriteModel.h"
#import "FMPageDetailVC.h"

@interface FMLocationFavoriteViewController () <UITableViewDelegate, UITableViewDataSource, FMUpdateTableDataProtocol, CLLocationManagerDelegate, LocationFavoriteTableViewCell>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) FMLocationFavoriteModel *model;

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (assign, nonatomic) CLLocationCoordinate2D coordinate;


@end

@implementation FMLocationFavoriteViewController {
    NSArray <PageObject*>*_listData;
    UIRefreshControl *_topRFControl;
    UIRefreshControl *_bottomRFControl;
    BOOL _isRefresh;

}

#pragma mark - life cycle
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.model = [[FMLocationFavoriteModel alloc] init];
        self.model.delegate = self;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navTitle = @"Địa điểm quan tâm";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ic_filter"] style:UIBarButtonItemStylePlain target:self action:@selector(didSelectRightBarButtonItem)];
    [self setLocationManager];
    [self setTableView];
    [self callDataRefresh];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if(_isRefresh) {
        [CommonFunction showLoadingView];
    }
}

#pragma mark - private
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

- (void)setTableView {
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 20, 0);
    [self.tableView registerNib:[UINib nibWithNibName:@"LocationFavoriteTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
}

- (void)didSelectRightBarButtonItem {
    NSLog(@"right barbutton");
}

- (void)callDataLoadMore {
    if([self checkIsRefresh]) {
        [self stopAnimationRefresh];
        return;
    }
    _isRefresh = YES;
    [self.model actionLoadMoreData];
}

- (void)callDataRefresh {
    if([self checkIsRefresh]) {
        [self stopAnimationRefresh];
        return;
    }
    _isRefresh = YES;
    [self.model actionPullToRefreshData];
}

- (BOOL)checkIsRefresh {
    return _isRefresh;
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

#pragma mark - FMUpdateDataProtocol
- (void)updateViewDataSuccess:(NSMutableArray *) listData {
    [self stopAnimationRefresh];
    _listData = listData.copy;
    [self.tableView reloadData];
}

- (void)updateViewDataEmpty {
    [self stopAnimationRefresh];
}

- (void)updateViewDataError {
    [self stopAnimationRefresh];
}

#pragma mark - TableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _listData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PageObject *obj = _listData[indexPath.row];
    LocationFavoriteTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.delegate = self;
    [cell bindDataPage:obj currentLocation:_coordinate];
    return cell;
}

#pragma mark - TableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - LocationFavoriteTableViewCell
- (void)showDetailPageWithID:(NSInteger)idPage {
    FMPageDetailVC *vc = [[FMPageDetailVC alloc] initWithIDPage:idPage];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
