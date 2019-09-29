//
//  FMListItemRateVC.m
//  FuzzyMark
//
//  Created by Tu Tran on 8/30/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import "FMListItemRateVC.h"
#import "FMRateViewController.h"
#import "Appdelegate.h"
#import "FMPageInfoAllRateCell.h"

@interface FMListItemRateVC () <FMPageInfoAllRateCellDelegate>

@end

@implementation FMListItemRateVC {
    PageInfo *_pageInfo;
    NSArray <RageView *> *_rates;
}

- (instancetype)initWithPageInfo:(PageInfo *) pageInfo
{
    self = [super init];
    if (self) {
        _pageInfo = pageInfo;
        _rates = pageInfo.rates;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.contentTableView registerNib:[UINib nibWithNibName:@"FMPageInfoRateCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.contentTableView registerNib:[UINib nibWithNibName:@"FMPageInfoAllRateCell" bundle:nil] forCellReuseIdentifier:@"cellButton"];
    self.statusView.layer.cornerRadius = self.statusView.layer.frame.size.height/2;
    self.lbStar.text = [NSString stringWithFormat:@"%ld", (long)_pageInfo.page_view.total_rate];
    self.lbnumberRate.text = [NSString stringWithFormat:@"%lu đánh giá", (unsigned long)_pageInfo.rates.count];
}

#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return _pageInfo.rates.count;
    } else if (section == 1) {
        return 1;
    } else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        FMPageInfoRateCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        [cell binDataWith:_rates[indexPath.row]];
        return cell;
    } else if (indexPath.section == 1) {
        FMPageInfoAllRateCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellButton"];
        return cell;
    } else {
        return [UITableViewCell new];
    }
}

#pragma mark - UITableViewDataSource
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (IBAction)didSelectRate:(id)sender {
    if (_pageInfo.is_rate) {
        return;
    }
    FMRateViewController *vc = [[FMRateViewController alloc] initWithIDPage:_pageInfo.page_view.pageId];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didSelectShowAllRate {
    
}

@end
