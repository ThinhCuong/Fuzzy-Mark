//
//  FZHomeViewController.m
//  FuzzyMark
//
//  Created by Nguyen Cuong on 4/14/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import "FZHomeViewController.h"
#import "FZHomeModel.h"
#import "FZHomeHeaderView.h"
#import "BaseCallApi.h"
#import "FMPromotionDetailVC.h"
#import "FZMenuHomeTableViewCell.h"
#import "FZItemMenuHomeTableViewCell.h"
#import "FZVourchersSearchViewController.h"
#import "FZHotlineViewController.h"
#import "FZHomeObject.h"
#import "FZRewardViewController.h"
#import "AppDelegate.h"
#import "FMNewsViewController.h"
#import "FZSearchViewController.h"
#import "FMWebViewController.h"
#import <CCBottomRefreshControl-umbrella.h>

@interface FZHomeViewController () <UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) FZHomeModel *dataModel;
@property (strong, nonatomic) NSArray *listBanner;
@property (nonatomic, strong) NSMutableArray<GroupInfoObject *> *groups;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (assign, nonatomic) CLLocationCoordinate2D coordinate;

@end

@implementation FZHomeViewController {
    UIRefreshControl *_topRFControl;
    BOOL _isRefresh;
    BOOL _firstShowSaleSuport;
}

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.hideNav = YES;
    [self setupModel];
    [self setTableView];
    [self setLocationCurren];
    [self reloadData];
    _firstShowSaleSuport = YES;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if(_isRefresh) {
        [CommonFunction showLoadingView];
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - private/setup
- (void)setupModel {
    self.dataModel = [[FZHomeModel alloc] init];
    self.dataModel.homeViewController = self;
}

- (void)setTableView {
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.dataModel registerCellForTableView:self.tableView];
    _topRFControl = [[UIRefreshControl alloc] init];
    [_topRFControl addTarget:self action:@selector(callDataRefresh) forControlEvents:UIControlEventValueChanged];
    if (@available(iOS 10.0, *)) {
        self.tableView.refreshControl = _topRFControl;
    } else {
        [self.tableView addSubview:_topRFControl];
    }
}

- (void)setLocationCurren {
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.delegate = self;
    
    _locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers;
    if([_locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]){
        [_locationManager requestWhenInUseAuthorization];
    }else{
        [_locationManager startUpdatingLocation];
    }
}

#pragma mark - private/getData
- (void)callDataRefresh {
    if([self checkIsRefresh]) {
        [self stopAnimationRefresh];
        return;
    }
    _isRefresh = YES;
    [self reloadData];
}

- (BOOL)checkIsRefresh {
    return _isRefresh;
}

- (void)stopAnimationRefresh {
    if(_topRFControl.isRefreshing) {
        [_topRFControl endRefreshing];
    }
    [CommonFunction hideLoadingView];
    _isRefresh = NO;
}

#pragma mark - public
- (void)reloadData {
    __block FZHomeViewController *blockSelf = self;
    [[BaseCallApi defaultInitWithBaseURL] getDataWithPath:GET_HOME_DATA andParam:@{} isShowfailureAlert:YES withSuccessBlock:^(id responseData) {
        [blockSelf stopAnimationRefresh];
        if ([responseData isKindOfClass:NSDictionary.class]) {
            if ([responseData codeForKey:@"error_code"] == 0) {
                FZHomeObject *data = [[FZHomeObject alloc] initWithDataDictionary:responseData[@"data"]];
                [self.dataModel bindData:data];
                [self.tableView reloadData];
                if (blockSelf->_firstShowSaleSuport) {
                    blockSelf->_firstShowSaleSuport = NO;
                    [blockSelf showSaleSuport];
                }
            } else {
                [CommonFunction showToast:[responseData stringForKey:@"message"]];
            }
        } else {
            [CommonFunction showToast:kMessageError];
        }
    } withFailBlock:^(id responseError) {
        [blockSelf stopAnimationRefresh];
        [CommonFunction showToast:kMessageError];
    }];
}

- (void)didSelectChooseItemWithIDVoucher:(NSInteger)idVoucher {
    FMPromotionDetailVC *vc = [[FMPromotionDetailVC alloc] initWithIDVoucher:idVoucher];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
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

#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.dataModel numberOfSectionsInTableView];
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataModel numberOfRowsInSection:section];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    return [self.dataModel tableView:tableView cellForRowAtIndexPath:indexPath];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        FZHomeHeaderView *heardView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"FZHomeHeaderView"];
        heardView.delegate = self;
        return heardView;
    }
    return [UIView new];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 50;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *footerView = [UIView new];
    footerView.backgroundColor = [UIColor colorWithRed:242.0f/255.0f
                                                 green:242.0f/255.0f
                                                  blue:242.0f/255.0f
                                                 alpha:1.0f];
    return footerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 0) {
        return 5;
    }
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    return;
}

#pragma mark - FZMenuHomeTableViewCellDelegate
- (void)didSelectSuportList:(SuportList) suportList {
    switch (suportList) {
        case Category_Suport: {
            [appDelegate selectTabWithIndex:1];
            break;
        }
        case Sale_Suport:{
            [self showSaleSuport];
            break;
        }
        case Hotline_Suport: {
            FZHotlineViewController *hotlineViewController = [[FZHotlineViewController alloc] init];
            hotlineViewController.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:hotlineViewController animated:YES];
            break;
        }
        case SNews_Suport: {
            FMNewsViewController *newsViewController = [[FMNewsViewController alloc] init];
            newsViewController.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:newsViewController animated:YES];
            break;
        }
        default:
            break;
    }
}

#pragma mark - nextViewController
- (void)didSelectWebviewWithLink:(NSString *)link andTitle:(NSString *)title {
    FMWebViewController *vc = [[FMWebViewController alloc] initWithLink:link andTitle:title];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didSelectVoucherID:(NSInteger)voucherID {
    FMPromotionDetailVC *vc = [[FMPromotionDetailVC alloc] initWithIDVoucher:voucherID];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didSelectSearchGroupsID:(NSInteger)groupsID placeholder:(NSString *) placeholder {
    FMVouchersObjecRequest *obj = [[FMVouchersObjecRequest alloc] init];
    [obj addGroupsID:groupsID];
    FZVourchersSearchViewController *vc = [[FZVourchersSearchViewController alloc] initWithObjectRequest:obj];
    vc.placeholderSearchBar = placeholder;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didSelectSearchCategoryID:(NSInteger)categoryID placeholder:(NSString *) placeholder {
    FMVouchersObjecRequest *obj = [[FMVouchersObjecRequest alloc] init];
    [obj addCategoryID:categoryID];
    FZVourchersSearchViewController *vc = [[FZVourchersSearchViewController alloc] initWithObjectRequest:obj];
    vc.placeholderSearchBar = placeholder;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didSelectSearchCategoryNew {
    
}

- (void)didSelectSearchCategoryMap {
    
    NSURL *appleURL = [NSURL URLWithString:@"http://maps.apple.com/?daddr=311+East+Buckfield+Road+Buckfield+Maine"];
    
    NSURL *googleURL = [[NSURL alloc]
                        initWithString:[NSString stringWithFormat:@"comgooglemaps://?daddr=%@", @"44.294349,-70.326973"]];
    
    NSURL *googleWebURL = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"http://www.maps.google.com/maps?daddr=%@",
                                   @"44.294349,-70.326973"]];
    
    if ([[UIApplication sharedApplication] canOpenURL:appleURL]) {
        [[UIApplication sharedApplication] openURL:appleURL options:@{} completionHandler:nil];
        return;
    }

    if ([[UIApplication sharedApplication] canOpenURL:googleURL]) {
        [[UIApplication sharedApplication] openURL:googleURL options:@{} completionHandler:nil];
        return;
    } else {
        [[UIApplication sharedApplication] openURL:googleWebURL options:@{} completionHandler:nil];
    }
}

- (void)showSaleSuport {
    FZRewardViewController *rewardViewController = [[FZRewardViewController alloc] initWithNibName:@"FZRewardViewController" bundle:nil];
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:rewardViewController];
    navi.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    [appDelegate.tabbarController presentViewController:navi animated:YES completion:nil];
}

#pragma mark - FZHomeHeaderDelegate
- (void)showPickerChooseLocation {
    
}

- (void)clickReward {
    
}

- (void)clickNews {
    
}

@end
