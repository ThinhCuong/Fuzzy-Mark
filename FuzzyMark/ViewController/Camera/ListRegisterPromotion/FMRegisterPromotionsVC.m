//
//  FMRegisterPromotionsVC.m
//  FuzzyMark
//
//  Created by Tu Tran on 5/3/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import "FMRegisterPromotionsVC.h"
#import "RegisterPromotionsTableViewCell.h"
#import "RegisterPromotionsHeaderViewCell.h"
#import "FMRegisterPromotionsModel.h"

@interface FMRegisterPromotionsVC () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *contentTableView;
@property (strong, nonatomic) FMRegisterPromotionsModel *model;

@end

@implementation FMRegisterPromotionsVC

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.model = [[FMRegisterPromotionsModel alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBar];
    [self setTableView];
}

#pragma mark - private
- (void)setNavigationBar {
    self.isHideNavigationBar = NO;
    self.navigationItem.title = @"Ưu đãi đã đăng ký";
    [self addRightButtonNavigationBar];
}

- (void)addRightButtonNavigationBar {
    UIImage *imgButton = [UIImage imageNamed:@"ic_search"];
    imgButton = [imgButton imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithImage:imgButton style:UIBarButtonItemStylePlain target:self action:@selector(didSelectRightButton)];
    self.navigationItem.rightBarButtonItem = rightBarButton;
}

- (void)didSelectRightButton {
    
}

- (void)setTableView {
    self.contentTableView.delegate = self;
    self.contentTableView.dataSource = self;
    [self.contentTableView registerNib:[UINib nibWithNibName:@"RegisterPromotionsTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.contentTableView registerNib:[UINib nibWithNibName:@"RegisterPromotionsHeaderViewCell" bundle:nil] forHeaderFooterViewReuseIdentifier:@"header"];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 42;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *footerView = [[UIView alloc] init];
    footerView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
    return footerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 4;
}

#pragma mark - UITableViewDelegate

@end
