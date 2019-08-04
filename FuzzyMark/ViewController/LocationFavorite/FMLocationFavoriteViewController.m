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

@interface FMLocationFavoriteViewController () <UITableViewDelegate, UITableViewDataSource, FMUpdateTableDataProtocol>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) FMLocationFavoriteModel *model;
@end

@implementation FMLocationFavoriteViewController {
    NSArray *_listData;
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
    [self setTableView];
//    [self callDataRefresh];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if(_isRefresh) {
        [CommonFunction showLoadingView];
    }
}

#pragma mark - private
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
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LocationFavoriteTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    return cell;
}

#pragma mark - TableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
