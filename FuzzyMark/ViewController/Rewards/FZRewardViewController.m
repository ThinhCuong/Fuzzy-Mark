//
//  FZRewardViewController.m
//  FuzzyMark
//
//  Created by Nguyen Cuong on 8/24/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import "FZRewardViewController.h"
#import "FZRewardTableViewCell.h"
#import "FMPromotionDetailVC.h"

@interface FZRewardViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation FZRewardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.hideNav = YES;
    [self.tableView registerNib:[UINib nibWithNibName:@"FZRewardTableViewCell" bundle:nil] forCellReuseIdentifier:@"FZRewardTableViewCell"];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [ConfigApp getListPromotion].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FZRewardTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FZRewardTableViewCell"];
    [cell bindData:[ConfigApp getListPromotion][indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    FMPromotionDetailVC *vc = [[FMPromotionDetailVC alloc] initWithIDVoucher:[ConfigApp getListPromotion][indexPath.row].idPromotion];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)closePopupAction:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
