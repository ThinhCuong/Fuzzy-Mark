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
#import "FZVouchersSearchModel.h"
#import <CCBottomRefreshControl-umbrella.h>
#import "FMPageDetailVC.h"
#import "MVUtilSearchViewController.h"

@interface FZVourchersSearchViewController ()<UITableViewDataSource, UITableViewDelegate, FMUpdateTableDataProtocol, LocationFavoriteTableViewCell, UISearchResultsUpdating>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) UISearchController *searchController;
@property (strong, nonatomic) FZVouchersSearchModel *model;

@end

@implementation FZVourchersSearchViewController {
    NSArray <RewardObject *> *_listVourcher;
    UIRefreshControl *_topRFControl;
    UIRefreshControl *_bottomRFControl;
    BOOL _isRefresh;

}

- (instancetype)initWithObjectRequest:(FMVouchersObjecRequest *) objRequest
{
    self = [super init];
    if (self) {
        self.model = [[FZVouchersSearchModel alloc] init];
        self.model.objRequest = objRequest?:[FMVouchersObjecRequest new];
        self.model.delegate = self;
    }
    return self;
}

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.hideNav = NO;
    self.hideBottomLineNav = YES;
    [self setSearchController];
    [self setTableViewContent];
    [self callDataRefresh];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if(_isRefresh) {
        [CommonFunction showLoadingView];
    }
}


#pragma mark - private
- (void)setSearchController {
    // init SearchController
    _searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    _searchController.obscuresBackgroundDuringPresentation = NO;
    _searchController.dimsBackgroundDuringPresentation = NO;
    _searchController.hidesNavigationBarDuringPresentation = NO;
    _searchController.searchResultsUpdater = self;
    
    // set SearchBar
    [_searchController.searchBar sizeToFit];
    _searchController.searchBar.placeholder = @"Nhà hàng gần tôi...";
    _searchController.searchBar.backgroundImage = [UIImage new];
    _searchController.searchBar.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1.0];
    UITextField *tfSearch = [_searchController.searchBar valueForKey:@"_searchField"];
    [tfSearch setFont:[UIFont fontWithName:@"Muli-Light" size:12.0]];
    
    self.navigationItem.titleView = _searchController.searchBar;
}

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
    [cell bindData:_listVourcher[indexPath.row] currentLocation:_model.coordinate];
    cell.delegate = self;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    RewardObject *reward = _listVourcher[indexPath.row];
    FMPromotionDetailVC *vc = [[FMPromotionDetailVC alloc] initWithIDVoucher:reward.rewardId];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - LocationFavoriteTableViewCell
- (void)showDetailPageWithID:(NSInteger)idPage {
    FMPageDetailVC *vc = [[FMPageDetailVC alloc] initWithIDPage:idPage];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - IBAction
- (IBAction)didSelectFilter:(id)sender {
    MVUtilSearchViewController *vc = [[MVUtilSearchViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
