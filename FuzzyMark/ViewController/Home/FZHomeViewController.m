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

@interface FZHomeViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) FZHomeModel *dataModel;
@end

@implementation FZHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isHideNavigationBar = YES;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.dataModel = [[FZHomeModel alloc] init];
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

@end
