//
//  FMNewsViewController.m
//  FuzzyMark
//
//  Created by Tu Tran on 4/17/19.
//  Copyright © 2019 Tu Tran. All rights reserved.
//

#import "FMNewsViewController.h"
#import "FZNewsObject.h"
#import "FMFirstNewsTableViewCell.h"
#import "FMSecondsNewsTableViewCell.h"
#import "FZNewsInfoDetailViewController.h"
#import "FMNewsModel.h"
#import <CCBottomRefreshControl-umbrella.h>

@interface FMNewsViewController () <UITableViewDataSource, UITableViewDelegate, FMUpdateTableDataProtocol>

@property (strong, nonatomic) FMNewsModel *model;

@end

@implementation FMNewsViewController {
    NSArray <FZNewsObject*>*_listNews;
    NSMutableArray <FZNewsObject*>*_listNewsRemovedFirstItem;
    UIRefreshControl *_topRFControl;
    UIRefreshControl *_bottomRFControl;
    BOOL _isRefresh;
}

#pragma mark - life cyvle
- (instancetype)init {
    self = [super init];
    if (self) {
        _model = [[FMNewsModel alloc] init];
        _model.delegate = self;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navTitle = @"Tin tức";
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
    
    [self.tableView registerNib:[UINib nibWithNibName:@"FMFirstNewsTableViewCell" bundle:nil] forCellReuseIdentifier:@"FMFirstNewsTableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"FMSecondsNewsTableViewCell" bundle:nil] forCellReuseIdentifier:@"FMSecondsNewsTableViewCell"];
    
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
    _listNews = listData.copy;
    if (listData.count > 0) {
        _listNewsRemovedFirstItem = listData.mutableCopy;
        [_listNewsRemovedFirstItem removeObjectAtIndex:0];
    }
    [self.tableView reloadData];
}

- (void)updateViewDataEmpty {
    [self stopAnimationRefresh];
}

- (void)updateViewDataError {
    [self stopAnimationRefresh];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else {
        return _listNewsRemovedFirstItem.count;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        FMFirstNewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FMFirstNewsTableViewCell"];
        [cell bindData:_listNews.firstObject isNewsDetail:NO];
         return cell;
    } else {
        FMSecondsNewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FMSecondsNewsTableViewCell"];
        [cell bindData:_listNewsRemovedFirstItem[indexPath.row]];
         return cell;
    }
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    FZNewsInfoDetailViewController *newsInfoViewController = [[FZNewsInfoDetailViewController alloc] initWithNibName:@"FZNewsInfoDetailViewController" bundle:nil];
    newsInfoViewController.hidesBottomBarWhenPushed = YES;
    if (indexPath.section == 0) {
        [newsInfoViewController callNewsFullNews:[NSString stringWithFormat:@"%ld", _listNews.firstObject.newsId]];
    } else {
        [newsInfoViewController callNewsFullNews:[NSString stringWithFormat:@"%ld", _listNewsRemovedFirstItem[indexPath.row].newsId]];
    }
    
    [self.navigationController pushViewController:newsInfoViewController animated:YES];
}

@end


