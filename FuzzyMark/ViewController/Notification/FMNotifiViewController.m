//
//  FMNotifiViewController.m
//  FuzzyMark
//
//  Created by Tu Tran on 4/14/19.
//  Copyright © 2019 Tu Tran. All rights reserved.
//

#import "FMNotifiViewController.h"
#import "FMNotifiTableViewCell.h"
#import "FMNotifiModel.h"
#import "Notifi.h"
#import <CCBottomRefreshControl-umbrella.h>

@interface FMNotifiViewController () <UITableViewDelegate, UITableViewDataSource, FMUpdateTableDataProtocol>
@property (weak, nonatomic) IBOutlet UITableView *contentTableView;
@property (strong, nonatomic) FMNotifiModel *model;
@end

@implementation FMNotifiViewController {
    NSArray <Notifi*> *_listData;
    UIRefreshControl *_topRFControl;
    UIRefreshControl *_bottomRFControl;
    BOOL _isRefresh;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.model = [[FMNotifiModel alloc] init];
        self.model.delegate = self;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setNavigationBar];
    [self setTableView];
    [SVProgressHUD setContainerView:self.view];
    [SVProgressHUD show];
    [self callDataRefresh];
}

#pragma mark - private
- (void)setNavigationBar {
    self.isHideNavigationBar = NO;
    self.navigationItem.title = @"Thông báo";
    [self addRightButtonNavigationBar];
}

- (void)setTableView {
    self.contentTableView.delegate = self;
    self.contentTableView.dataSource = self;
    [self.contentTableView registerNib:[UINib nibWithNibName:@"FMNotifiTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
     
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

- (void)addRightButtonNavigationBar {
    UIImage *imgButton = [UIImage imageNamed:@"ic_menu_nv"];
    imgButton = [imgButton imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithImage:imgButton style:UIBarButtonItemStylePlain target:self action:@selector(didSelectRightButton)];
    self.navigationItem.rightBarButtonItem = rightBarButton;
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

- (void)didSelectRightButton {
    
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
    FMNotifiTableViewCell *cell = [self.contentTableView dequeueReusableCellWithIdentifier:@"cell"];
    [cell binData:_listData[indexPath.row]];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.contentTableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
