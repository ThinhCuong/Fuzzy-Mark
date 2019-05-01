//
//  FMUserInforViewController.m
//  FuzzyMark
//
//  Created by Tu Tran on 4/14/19.
//  Copyright © 2019 Tu Tran. All rights reserved.
//

#import "FMUserInforViewController.h"
#import "FMUserInforModel.h"
#import "FMMenuTabbleViewCell.h"
#import "FMUserInforTableViewCell.h"

@interface FMUserInforViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableViewContent;
@property (strong, nonatomic) FMUserInforModel *model;
@end

@implementation FMUserInforViewController {
    NSArray <NSArray *> *_listMenuBlock;
}

#pragma mark - lifeCycle
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self) {
        self.model = [[FMUserInforModel alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.isHideNavigationBar = YES;
    [self setTableViewContent];
    
    __weak FMUserInforViewController *weakSelf = self;
    [self.model initDataAllCellBlockWithSuccessBlock:^(NSArray * listMenuBlock) {
        [weakSelf reloadBlockCell:listMenuBlock];
    }];
    [self.model initDataFirstCellUserWithSuccessBlock:^(NSArray * obj) {
    }];
}

#pragma mark - private
- (void)setTableViewContent {
    self.tableViewContent.delegate = self;
    self.tableViewContent.dataSource = self;
    [self.tableViewContent registerNib:[UINib nibWithNibName:@"FMUserInforTableViewCell" bundle:nil] forCellReuseIdentifier:@"cellUser"];
    [self.tableViewContent registerNib:[UINib nibWithNibName:@"FMMenuTabbleViewCell" bundle:nil] forCellReuseIdentifier:@"cellMenu"];
    self.tableViewContent.contentInset = UIEdgeInsetsMake(0, 0, 50, 0);
}

- (void)reloadBlockCell:(NSArray *) listMenuBlock {
    _listMenuBlock = listMenuBlock;
    [self.tableViewContent beginUpdates];
    [self.tableViewContent reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationAutomatic];
    [self.tableViewContent reloadSections:[NSIndexSet indexSetWithIndex:2] withRowAnimation:UITableViewRowAnimationAutomatic];
    [self.tableViewContent endUpdates];
}

#pragma mark - IBAction
- (IBAction)didSelectBackButton:(id)sender {
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else if (section == 1) {
        return 4;
    } else if (section == 2) {
        return 2;
    } else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return [tableView dequeueReusableCellWithIdentifier:@"cellUser"];
    } else {
        FMMenuTabbleViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellMenu"];
        [cell binDataWith:_listMenuBlock[indexPath.section - 1][indexPath.row]];
        if (indexPath.row == _listMenuBlock[indexPath.section - 1].count - 1) {
            cell.hideBotomLine = YES;
        } else {
            cell.hideBotomLine = NO;
        }
        return cell;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *footerView = [[UIView alloc] init];
    if(section == 1) {
        footerView.backgroundColor = [UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1.0];
    } else {
        footerView.backgroundColor = [UIColor clearColor];
    }
    return footerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 1) {
        return 8.0f;
    } else {
        return 0.01f;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01f;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (indexPath.section == 0) return
}

@end
