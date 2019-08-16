//
//  FMHistoryPointViewController.m
//  FuzzyMark
//
//  Created by Tu Tran on 5/16/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import "FMHistoryPointViewController.h"
#import "FMHistoryPointModel.h"
#import "HistoryPointTableViewCell.h"
#import "HistoryPointHeaderTableViewCell.h"
#import <CCBottomRefreshControl-umbrella.h>

@interface FMHistoryPointViewController () <UITableViewDelegate, UITableViewDataSource, FMUpdateTableDataProtocol>
@property (strong, nonatomic) FMHistoryPointModel *model;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation FMHistoryPointViewController {
    NSArray *_listHistoryBill;
    UIRefreshControl *_topRFControl;
    UIRefreshControl *_bottomRFControl;
    BOOL _isRefresh;
}

#pragma mark - life cycle
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.model = [[FMHistoryPointModel alloc] init];
        self.model.delegate = self;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navTitle = @"Lịch sử nhận điểm thưởng";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ic_info"] style:UIBarButtonItemStylePlain target:self action:@selector(didSelectRightBarButtonItem)];
    
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
- (void)setTableViewContent {
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"HistoryPointTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"HistoryPointHeaderTableViewCell" bundle:nil] forCellReuseIdentifier:@"headerCell"];
    
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
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
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
    _listHistoryBill = listData.copy;
    [self.tableView reloadData];
}

- (void)updateViewDataEmpty {
    [self stopAnimationRefresh];
}

- (void)updateViewDataError {
    [self stopAnimationRefresh];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _listHistoryBill.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row == 0) {
        HistoryPointHeaderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"headerCell"];
        [cell binDataWithPoint:0];
        return cell;
    } else {
        HistoryPointTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        [cell binData:_listHistoryBill[indexPath.row - 1]];
        return cell;
    }
}



@end
