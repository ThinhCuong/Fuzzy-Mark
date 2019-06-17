//
//  FZHomeModel.m
//  FuzzyMark
//
//  Created by Nguyen Cuong on 4/15/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import "FZHomeModel.h"
#import "FZMenuHomeTableViewCell.h"
#import "FZItemMenuHomeTableViewCell.h"
#import "FZVourchersSearchViewController.h"

@interface FZHomeModel() {
    FZHomeJsonModel *_homeData;
}

@end
@implementation FZHomeModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        // call api
    }
    return self;
}

- (void)registerCellForTableView:(UITableView *)tableView {
    [tableView registerNib:[UINib nibWithNibName:@"FZHomeHeaderView" bundle:nil] forHeaderFooterViewReuseIdentifier:@"FZHomeHeaderView"];
    [tableView registerNib:[UINib nibWithNibName:@"FZMenuHomeTableViewCell" bundle:nil] forCellReuseIdentifier:@"FZMenuHomeTableViewCell"];
    [tableView registerNib:[UINib nibWithNibName:@"FZItemMenuHomeTableViewCell" bundle:nil] forCellReuseIdentifier:@"FZItemMenuHomeTableViewCell"];
}

- (void)bindData:(FZHomeJsonModel *)homeData {
    _homeData = homeData;
}

- (void)goVourchersSearchScreen {
    FZVourchersSearchViewController *rewardInfoVC = [[FZVourchersSearchViewController alloc] initWithNibName:@"FZVourchersSearchViewController" bundle:nil];
    rewardInfoVC.hidesBottomBarWhenPushed = YES;
    [self.homeViewController.navigationController pushViewController:rewardInfoVC animated:YES];
}

- (NSInteger )numberOfSectionsInTableView {
    return 2;
}

- (NSInteger )numberOfRowsInSection:(NSInteger )section {
    switch (section) {
        case 0:
            return 1;
            break;
        default:
            return _homeData.groups.count;
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        FZMenuHomeTableViewCell *menuHomeCell = [tableView dequeueReusableCellWithIdentifier:@"FZMenuHomeTableViewCell"];
        [menuHomeCell bindData:_homeData];
        [menuHomeCell.restaurentButton addTarget:self action:@selector(goVourchersSearchScreen) forControlEvents:UIControlEventTouchUpInside];
        return menuHomeCell;
    } else {
        FZItemMenuHomeTableViewCell *itemMenuHomeCell = [tableView dequeueReusableCellWithIdentifier:@"FZItemMenuHomeTableViewCell"];
        [itemMenuHomeCell bindData:_homeData.groups[indexPath.row].vouchers_vertical listVoucherHorizontal:_homeData.groups[indexPath.row].vouchers_horizontal];
        return itemMenuHomeCell;
    }
}

@end
