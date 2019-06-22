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
#import "FZHomeJsonModel.h"
#import "FMPromotionDetailVC.h"
#import "FZMenuHomeTableViewCell.h"
#import "FZItemMenuHomeTableViewCell.h"
#import "FZVourchersSearchViewController.h"


@interface FZHomeViewController () <UITableViewDataSource, UITableViewDelegate, FZMenuHomeTableViewDelegate, FZItemMenuHomeTableViewDelegate, FZHomeHeaderDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) FZHomeModel *dataModel;
@property (strong, nonatomic) NSArray *listBanner;
@property (nonatomic, strong) NSMutableArray<FZGroupJsonModel> *groups;

@end

@implementation FZHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isHideNavigationBar = YES;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self testApi];
    self.dataModel = [[FZHomeModel alloc] init];
    self.dataModel.homeViewController = self;
    [self.dataModel registerCellForTableView:self.tableView];
    
}

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

- (void)testApi {
    
    NSDictionary *params = @{
                             @"token": @"abd",
                             };
    [SVProgressHUD setContainerView:self.view];
    [SVProgressHUD show];
    [[BaseCallApi defaultInitWithBaseURL] getDataWithPath:@"get-home-data" andParam:params isShowfailureAlert:YES withSuccessBlock:^(id responseData) {
        [SVProgressHUD dismiss];
        [SVProgressHUD setBackgroundLayerColor:UIColor.redColor];
        if (responseData) {
            FZHomeJsonModel *homeData = [[FZHomeJsonModel alloc] initWithDictionary:responseData[@"data"] error:nil];
            [self.dataModel bindData:homeData];
            [self.tableView reloadData];
        }
    } withFailBlock:^(id responseError) {
        [SVProgressHUD dismiss];
    }];
}

- (void)didSelectChooseItemWithIDVoucher:(NSString *) idVoucher {
    FMPromotionDetailVC *vc = [[FMPromotionDetailVC alloc] initWithIDVoucher:@"123"];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didSelectSuportList:(SuportList ) indexChoose {
    switch (indexChoose) {
        case 0: {
            FZVourchersSearchViewController *rewardInfoVC = [[FZVourchersSearchViewController alloc] initWithNibName:@"FZVourchersSearchViewController" bundle:nil];
            rewardInfoVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:rewardInfoVC animated:YES];
            break;
        }
        case 1:
            
            break;
        case 2:
            
            break;
        case 3:
            
            break;
        default:
            break;
    }
}

- (void)didSelectCategoryList:(CategoryList ) indexChoose {
    FZVourchersSearchViewController *rewardInfoVC = [[FZVourchersSearchViewController alloc] initWithNibName:@"FZVourchersSearchViewController" bundle:nil];
    rewardInfoVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:rewardInfoVC animated:YES];
}

@end
