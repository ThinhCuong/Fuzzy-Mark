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

@interface FMListItemRateVC ()

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
    self.statusView.layer.cornerRadius = self.statusView.layer.frame.size.height/2;
    self.lbStar.text = [NSString stringWithFormat:@"%ld", (long)_pageInfo.page_view.total_rate];
    self.lbnumberRate.text = [NSString stringWithFormat:@"%lu đánh giá", (unsigned long)_pageInfo.rates.count];
}

#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _pageInfo.rates.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FMPageInfoRateCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    [cell binDataWith:_rates[indexPath.row]];
    return cell;
}

#pragma mark - UITableViewDataSource
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (IBAction)didSelectRate:(id)sender {
    FMRateViewController *vc = [[FMRateViewController alloc] initWithIDPage:_pageInfo.page_view.pageId];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
