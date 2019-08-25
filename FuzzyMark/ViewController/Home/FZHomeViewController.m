//
//  FZHomeViewController.m
//  FuzzyMark
//
//  Created by Nguyen Cuong on 4/14/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import "FZHomeViewController.h"

@interface FZHomeViewController ()

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

- (void)didSelectSuportList:(SuportList ) indexChoose {
    switch (indexChoose) {
        case 0: {
            FZVourchersSearchViewController *rewardInfoVC = [[FZVourchersSearchViewController alloc] initWithKeyWord:@""];
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
    NSString *category;
    switch (indexChoose) {
        case Restaurant_Category:
            category = @"Restaurant";
            break;
        case Hotel_Category:
            category = @"Hotel";
            break;
        case Travel_Category:
            category = @"Travel";
            break;
        case Store_Category:
            category = @"Store";
            break;
        case News_Category:
            category = @"News";
            break;
        case Map_Category:
            category = @"Map";
            break;
        default:
            break;
    }
    FZVourchersSearchViewController *rewardInfoVC = [[FZVourchersSearchViewController alloc] initWithKeyWord:@""];
    rewardInfoVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:rewardInfoVC animated:YES];
}

- (void)clickToHotline {
    FZHotlineViewController *hotlineViewController = [[FZHotlineViewController alloc] initWithNibName:@"FZHotlineViewController" bundle:nil];
    hotlineViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:hotlineViewController animated:YES];
}

#pragma mark - FZHomeHeaderDelegate
- (void)showPickerChooseLocation {
    
}

@end
