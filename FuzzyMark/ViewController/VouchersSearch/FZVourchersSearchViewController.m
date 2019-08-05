//
//  FZVourchersSearchViewController.m
//  FuzzyMark
//
//  Created by Nguyen Cuong on 6/13/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import "FZVourchersSearchViewController.h"
#import "FZVourcherSearchTableViewCell.h"
#import "FZHomeModel.h"
#import "FMPromotionDetailVC.h"

@interface FZVourchersSearchViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) NSArray <FZGroupInfoJsonModel> *listVourcher;

@end

@implementation FZVourchersSearchViewController {
    NSString *_keyWord;
}

- (instancetype)initWithKeyWord:(NSString *)keyWord
{
    self = [super init];
    if (self) {
        _keyWord = keyWord;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.tableView registerNib:[UINib nibWithNibName:@"FZVourcherSearchTableViewCell" bundle:nil] forCellReuseIdentifier:@"FZVourcherSearchTableViewCell"];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self callVouchersSearch];
}


- (IBAction)backToParentViewController:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listVourcher.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FZVourcherSearchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FZVourcherSearchTableViewCell"];
    [cell bindData:self.listVourcher[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    FZGroupInfoJsonModel *groupID = self.listVourcher[indexPath.row];
    NSString *voucherID = [groupID.id stringValue];
    FMPromotionDetailVC *vc = [[FMPromotionDetailVC alloc] initWithIDVoucher:voucherID];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)callVouchersSearch {
    
    NSDictionary *params = @{
                             @"token": [UserInfo getUserToken] ?: @"",
                             @"limit": @"50",
                             @"offset" : @(_listVourcher.count),
                             @"keyword" : _keyWord ?: @"",
                             @"lat" : @"20.9813266",
                             @"lng" : @"105.7874813",
                             @"categories" : @"",
                             @"services" : @""
                             };
    
    [SVProgressHUD setContainerView:self.view];
    [SVProgressHUD show];
    [[BaseCallApi defaultInitWithBaseURL] getDataWithPath:@"vouchers/search" andParam:params isShowfailureAlert:YES withSuccessBlock:^(id responseData) {
        [SVProgressHUD dismiss];
        if (responseData) {
            FzVourcherSearch *GroupInfoData = [[FzVourcherSearch alloc] initWithDictionary:responseData error:nil];
            self.listVourcher = GroupInfoData.data;
            [self.tableView reloadData];
        }
    } withFailBlock:^(id responseError) {
        [SVProgressHUD dismiss];
    }];
}

@end
