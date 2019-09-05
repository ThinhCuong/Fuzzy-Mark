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
#import "FMPromotionDetailVC.h"
#import "FZMenuHomeTableViewCell.h"
#import "FZItemMenuHomeTableViewCell.h"
#import "FZVourchersSearchViewController.h"
#import "FZHotlineViewController.h"
#import "FZHomeObject.h"
#import "FZRewardViewController.h"
#import "AppDelegate.h"
#import "FMNewsViewController.h"
#import "FZSearchViewController.h"
#import "FMWebViewController.h"

@interface FZHomeViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) FZHomeModel *dataModel;
@property (strong, nonatomic) NSArray *listBanner;
@property (nonatomic, strong) NSMutableArray<GroupInfoObject *> *groups;

@end

@implementation FZHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.hideNav = YES;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self getDataHome];
    self.dataModel = [[FZHomeModel alloc] init];
    self.dataModel.homeViewController = self;
    [self.dataModel registerCellForTableView:self.tableView];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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

#pragma mark - private
- (void)getDataHome {
    NSDictionary *params = @{};
    [CommonFunction showLoadingView];
    [[BaseCallApi defaultInitWithBaseURL] getDataWithPath:GET_HOME_DATA andParam:params isShowfailureAlert:YES withSuccessBlock:^(id responseData) {
        [CommonFunction hideLoadingView];
        if ([responseData isKindOfClass:NSDictionary.class]) {
            if ([responseData codeForKey:@"error_code"] == 0) {
                FZHomeObject *data = [[FZHomeObject alloc] initWithDataDictionary:responseData[@"data"]];
                [self.dataModel bindData:data];
                [self.tableView reloadData];
            } else {
                [CommonFunction showToast:[responseData stringForKey:@"message"]];
            }
        } else {
            [CommonFunction showToast:kMessageError];
        }
    } withFailBlock:^(id responseError) {
        [CommonFunction hideLoadingView];
        [CommonFunction showToast:kMessageError];
    }];
}

- (void)didSelectChooseItemWithIDVoucher:(NSInteger)idVoucher {
    FMPromotionDetailVC *vc = [[FMPromotionDetailVC alloc] initWithIDVoucher:idVoucher];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - FZMenuHomeTableViewCellDelegate
- (void)didSelectSuportList:(SuportList) suportList {
    switch (suportList) {
        case Category_Suport: {
            [appDelegate selectTabWithIndex:1];
            break;
        }
        case Sale_Suport:{
            FZRewardViewController *rewardViewController = [[FZRewardViewController alloc] initWithNibName:@"FZRewardViewController" bundle:nil];
            UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:rewardViewController];
            navi.modalPresentationStyle = UIModalPresentationOverCurrentContext;
            [appDelegate.tabbarController presentViewController:navi animated:YES completion:nil];
            break;
        }
        case Hotline_Suport: {
            FZHotlineViewController *hotlineViewController = [[FZHotlineViewController alloc] init];
            hotlineViewController.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:hotlineViewController animated:YES];
            break;
        }
        case SNews_Suport: {
            FMNewsViewController *newsViewController = [[FMNewsViewController alloc] initWithNibName:@"FMNewsViewController" bundle:nil];
            newsViewController.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:newsViewController animated:YES];
            break;
        }
        default:
            break;
    }
}

- (void)didSelectWebviewWithLink:(NSString *)link andTitle:(NSString *)title {
    FMWebViewController *vc = [[FMWebViewController alloc] initWithLink:link andTitle:title];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didSelectVoucherID:(NSInteger)voucherID {
    FMPromotionDetailVC *vc = [[FMPromotionDetailVC alloc] initWithIDVoucher:voucherID];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didSelectSearchCategoryID:(NSInteger)categoryID {
    FMVouchersObjecRequest *obj = [[FMVouchersObjecRequest alloc] init];
    [obj addCategoryID:categoryID];
    FZVourchersSearchViewController *vc = [[FZVourchersSearchViewController alloc] initWithObjectRequest:obj];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - FZHomeHeaderDelegate
- (void)showPickerChooseLocation {
    
}

- (void)clickReward {
    
}

- (void)clickNews {
    
}

@end
