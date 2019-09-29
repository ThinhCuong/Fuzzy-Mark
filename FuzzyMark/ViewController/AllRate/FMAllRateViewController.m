//
//  FMAllRateViewController.m
//  FuzzyMark
//
//  Created by Tu Tran on 9/23/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import "FMAllRateViewController.h"
#import <CCBottomRefreshControl-umbrella.h>
#import "FMAllRateModel.h"
#import "FMAllRateCell.h"

@interface FMAllRateViewController () <FMUpdateTableDataProtocol, UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) FMAllRateModel *model;
@property (weak, nonatomic) IBOutlet UITableView *contentTableView;
@property (weak, nonatomic) IBOutlet UILabel *lbRate;
@property (weak, nonatomic) IBOutlet UILabel *lbNumberComment;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightViewRate;

@end

@implementation FMAllRateViewController {
    NSArray *_listData;
    UIRefreshControl *_topRFControl;
    UIRefreshControl *_bottomRFControl; 
    BOOL _isRefresh;
}

#pragma mark - life cycle
- (instancetype)init {
    self = [super init];
    if (self) {
        self.model = [[FMAllRateModel alloc] init];
        self.model.delegate = self;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setNavigationBar];
    [self setTableView];
    [self callDataRefresh];

}

#pragma mark - private
- (void)setNavigationBar {
    self.navTitle = @"Đánh giá ưu đãi";
}

- (void)setTableView {
    self.contentTableView.delegate = self;
    self.contentTableView.dataSource = self;
    [self.contentTableView registerNib:[UINib nibWithNibName:@"FMAllRateCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
    _topRFControl = [[UIRefreshControl alloc] init];
    [_topRFControl addTarget:self action:@selector(callDataRefresh) forControlEvents:UIControlEventValueChanged];
    if (@available(iOS 10.0, *)) {
        self.contentTableView.refreshControl = _topRFControl;
    } else {
        [self.contentTableView addSubview:_topRFControl];
    }
    
    _bottomRFControl = [UIRefreshControl new];
    [_bottomRFControl addTarget:self action:@selector(callDataLoadMore) forControlEvents:UIControlEventValueChanged];
    self.contentTableView.bottomRefreshControl = _bottomRFControl;
    self.contentTableView.contentInset = UIEdgeInsetsMake(0, 0, 20, 0);
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
    [SVProgressHUD dismiss];
    _isRefresh = NO;
}

#pragma mark - FMUpdateDataProtocol
- (void)updateViewDataSuccess:(NSMutableArray *) listData {
    [self stopAnimationRefresh];
    _listData = listData.copy;
    [self.contentTableView reloadData];
}

- (void)updateViewDataEmpty {
    [self stopAnimationRefresh];
}

- (void)updateViewDataError {
    [self stopAnimationRefresh];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _listData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FMAllRateCell *cell = [self.contentTableView dequeueReusableCellWithIdentifier:@"cell"];
    RageView *rateView = _listData[indexPath.row];
    [cell binData:rateView];
    return cell;
}

@end
