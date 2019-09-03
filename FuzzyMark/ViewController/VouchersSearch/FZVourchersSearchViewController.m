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

@interface FZVourchersSearchViewController ()<UITableViewDataSource, UITableViewDelegate, FMUpdateTableDataProtocol, LocationFavoriteTableViewCell, UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UILabel *lbNumbber;
@property (weak, nonatomic) IBOutlet UIView *viewNumber;
@property (strong, nonatomic) FZVouchersSearchModel *model;

@end

@implementation FZVourchersSearchViewController {
    NSArray <RewardObject *> *_listVourcher;
    NSArray <RewardObject *> *_filterServices;
    NSString *_keySearch;
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
    self.hideNav = YES;
    [self setSearchBar];
    [self setTableViewContent];
    [self callDataRefresh];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if(_isRefresh) {
        [CommonFunction showLoadingView];
    }
}

- (void)dealloc {
    [self.model.objRequest removeObserver:self forKeyPath:@"countService"];
}

#pragma mark - private
- (void)setSearchBar {
    _searchBar.placeholder = @"Nhà hàng gần tôi...";
    _searchBar.backgroundImage = [UIImage new];
    _searchBar.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1.0];
    _searchBar.delegate = self;
    
    @try {
        UITextField *tfSearch = [_searchBar valueForKey:@"_searchField"];
        [tfSearch setFont:[UIFont fontWithName:@"Muli-Light" size:12.0]];
        [tfSearch setReturnKeyType:UIReturnKeyDone];
    } @catch (NSException *exception) {
        
    }
    
    self.viewNumber.layer.cornerRadius = self.viewNumber.frame.size.height/2;
    self.lbNumbber.text = [NSString stringWithFormat:@"%lu", (unsigned long)_model.objRequest.servicesID.count];
    [self.model.objRequest addObserver:self forKeyPath:@"countService" options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:nil];
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

#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"countService"]) {
        self.lbNumbber.text = [NSString stringWithFormat:@"%lu",(unsigned long)self.model.objRequest.servicesID.count];
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
    if (_keySearch.length > 0) {
        return _filterServices.count;
    } else {
        return _listVourcher.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LocationFavoriteTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LocationFavoriteTableViewCell"];
    cell.delegate = self;
    if (_keySearch.length > 0) {
        [cell bindData:_filterServices[indexPath.row] currentLocation:_model.coordinate];
        return cell;
    } else {
        [cell bindData:_listVourcher[indexPath.row] currentLocation:_model.coordinate];
        return cell;
    }
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
    MVUtilSearchViewController *vc = [[MVUtilSearchViewController alloc] initWith:self.model.objRequest];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UISearchBarDelegate
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    _keySearch = searchText;
    NSPredicate *searchPredicate = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"SELF.name CONTAINS[cd] '%@'", _keySearch]];
    NSArray *arr = [_listVourcher filteredArrayUsingPredicate:searchPredicate];
    _filterServices = arr?:@[];
    
    [self.tableView reloadData];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [_searchBar endEditing:YES];
}

@end
