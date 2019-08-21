//
//  FMRegisterPromotionViewController.m
//  FuzzyMark
//
//  Created by Tu Tran on 5/19/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import "FMRegisterPromotionViewController.h"
#import <CCBottomRefreshControl-umbrella.h>
#import "FMRegisterPromotionModel.h"
#import "RegisterPromotionCell.h"
#import "RegisterPromotionHeaderCell.h"
#import "FMCameraViewController.h"
#import "AppDelegate.h"

@interface FMRegisterPromotionViewController () <UITableViewDelegate, UITableViewDataSource, FMUpdateTableDataProtocol>

@property (strong, nonatomic) FMRegisterPromotionModel *model;
@property (weak, nonatomic) IBOutlet UITableView *contentTableView;

@end

@implementation FMRegisterPromotionViewController {
    NSArray *_listData;
    UIRefreshControl *_topRFControl;
    UIRefreshControl *_bottomRFControl;
    BOOL _isRefresh;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.model = [[FMRegisterPromotionModel alloc] init];
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

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if(_isRefresh) {
        [CommonFunction showLoadingView];
    }
}

#pragma mark - private
- (void)setNavigationBar {
    self.navTitle = @"Ưu đãi quan tâm";
    [self addRightButtonNavigationBar];
}

- (void)setTableView {
    self.contentTableView.delegate = self;
    self.contentTableView.dataSource = self;
    [self.contentTableView registerNib:[UINib nibWithNibName:@"RegisterPromotionCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.contentTableView registerNib:[UINib nibWithNibName:@"RegisterPromotionHeaderCell" bundle:nil] forHeaderFooterViewReuseIdentifier:@"header"];
    
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
    UIImage *imgButton = [UIImage imageNamed:@"ic_search"];
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
    NSLog(@"Click Right Button");
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
    RegisterPromotionCell *cell = [self.contentTableView dequeueReusableCellWithIdentifier:@"cell"];
    Voucher *obj = _listData[indexPath.row];
    [cell binDataWithVoucher:obj];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.contentTableView deselectRowAtIndexPath:indexPath animated:YES];
    Voucher *obj = _listData[indexPath.row];
    __block FMRegisterPromotionViewController *_blockSelf = self;
    [appDelegate loginRequiredWithSuccessBlock:^(BOOL isSuccess) {
        if(!isSuccess) {
            return;
        }
        FMCameraViewController *vc = [[FMCameraViewController alloc] initWithVoucherID:obj.idVoucher];
        vc.hidesBottomBarWhenPushed = YES;
        [_blockSelf.navigationController pushViewController:vc animated:YES];
    }];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    RegisterPromotionHeaderCell *cell = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"header"];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return UITableViewAutomaticDimension;
}

@end
