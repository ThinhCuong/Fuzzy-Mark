//
//  FMItemHistoryBillVC.m
//  FuzzyMark
//
//  Created by Tu Tran on 5/6/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import "FMItemHistoryBillVC.h"
#import "FMItemHistoryBillModel.h"
#import "HistoryBillHeaderCell.h"
#import "HistoryBillFooterCell.h"
#import "HistoryBillTableViewCell.h"
#import <CCBottomRefreshControl-umbrella.h>
#import "FMDetailHistoryViewController.h"

@interface FMItemHistoryBillVC () <UITableViewDelegate, UITableViewDataSource, FMUpdateTableDataProtocol>

@property (strong, nonatomic) FMItemHistoryBillModel *model;
@property (weak, nonatomic) IBOutlet UITableView *tableViewContent;


@end

@implementation FMItemHistoryBillVC {
    NSArray <HistoryBill*> *_listData;
    UIRefreshControl *_topRFControl;
    UIRefreshControl *_bottomRFControl;
    BOOL _isRefresh;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.model = [[FMItemHistoryBillModel alloc] init];
        self.model.delegate = self;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTableView];
    [self callDataRefresh];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if(_isRefresh) {
        [SVProgressHUD setContainerView:self.view];
        [SVProgressHUD show];
    }
}

#pragma mark - private
- (void)setTableView {
    [self.tableViewContent registerNib:[UINib nibWithNibName:@"HistoryBillTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.tableViewContent registerNib:[UINib nibWithNibName:@"HistoryBillHeaderCell" bundle:nil] forHeaderFooterViewReuseIdentifier:@"header"];
    [self.tableViewContent registerNib:[UINib nibWithNibName:@"HistoryBillFooterCell" bundle:nil] forHeaderFooterViewReuseIdentifier:@"footer"];
    
    _topRFControl = [[UIRefreshControl alloc] init];
    [_topRFControl addTarget:self action:@selector(callDataRefresh) forControlEvents:UIControlEventValueChanged];
    if (@available(iOS 10.0, *)) {
        self.tableViewContent.refreshControl = _topRFControl;
    } else {
        [self.tableViewContent addSubview:_topRFControl];
    }
    
    _bottomRFControl = [UIRefreshControl new];
    [_bottomRFControl addTarget:self action:@selector(callDataLoadMore) forControlEvents:UIControlEventValueChanged];
    self.tableViewContent.bottomRefreshControl = _bottomRFControl;
    self.tableViewContent.contentInset = UIEdgeInsetsMake(0, 0, 20, 0);
    
    self.tableViewContent.delegate = self;
    self.tableViewContent.dataSource = self;
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
    [self.tableViewContent reloadData];
}

- (void)updateViewDataEmpty {
    [self stopAnimationRefresh];
}

- (void)updateViewDataError {
    [self stopAnimationRefresh];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _listData.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HistoryBillTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    [cell binData:_listData[indexPath.section]];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    HistoryBillHeaderCell *header = (HistoryBillHeaderCell *) [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"header"];
    [header binData:_listData[section]];
     return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 32;
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *) view;
    header.contentView.backgroundColor = [UIColor whiteColor];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    HistoryBillFooterCell *footer = (HistoryBillFooterCell *) [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"footer"];
    [footer binData:_listData[section]];
    return footer;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForFooterInSection:(NSInteger)section {
    return 44;
}

- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section {
    UITableViewHeaderFooterView *footer = (UITableViewHeaderFooterView *) view;
    footer.contentView.backgroundColor = [UIColor whiteColor];
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    FMDetailHistoryViewController *vc = [[FMDetailHistoryViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}


@end
