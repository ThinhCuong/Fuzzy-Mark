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
#import "FMHistoryBillViewController.h"
#import "FMHistoryPointViewController.h"
#import "FMLocationFavoriteViewController.h"
#import "FMChangeUserInforViewController.h"

@interface FMUserInforViewController () <UITableViewDelegate, UITableViewDataSource, FMUserInforTableViewCellProtocol>
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
    self.tableViewContent.contentInset = UIEdgeInsetsMake(0, 0, 20, 0);
}

- (void)reloadBlockCell:(NSArray *) listMenuBlock {
    _listMenuBlock = listMenuBlock;
    [self.tableViewContent beginUpdates];
    [self.tableViewContent reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationAutomatic];
    [self.tableViewContent reloadSections:[NSIndexSet indexSetWithIndex:2] withRowAnimation:UITableViewRowAnimationAutomatic];
    [self.tableViewContent endUpdates];
}

- (void)didSelectBlockCell:(FMMenuTabbleViewCell *) cell {
    if(!cell) {
        return;
    }
    switch (cell.typeBlock) {
        case FMTableViewCellBlockFavoritePlaces: {
            FMLocationFavoriteViewController *vc = [[FMLocationFavoriteViewController alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case FMTableViewCellBlockUserInfor: {
            FMChangeUserInforViewController *vc = [[FMChangeUserInforViewController alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case FMTableViewCellBlockChangePassWord:
            
            break;
        case FMTableViewCellBlockChangePhoneNumber:
            
            break;
        case FMTableViewCellBlockPoliciesAndTerms:
            
            break;
        case FMTableViewCellBlockLogOut:
            
            break;
        default:
            break;
    }
}

#pragma mark - FMUserInforTableViewCellProtocol
- (void)didSelectButtonHistory {
    FMHistoryBillViewController *vc = [[FMHistoryBillViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didSelectButtonPoint {
    FMHistoryPointViewController *vc = [[FMHistoryPointViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didSelectButtonAddImageUser {
    
}

- (void)didSelectEmailView {
    
}

- (void)didSelectPhoneView {
    
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
        FMUserInforTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellUser"];
        cell.delegate = self;
        return cell;
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
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    // Click Cell User
    if(indexPath.section == 0 && indexPath.row == 0) {
        return;
    }
    // Click Cell Block
    [self didSelectBlockCell:[tableView cellForRowAtIndexPath:indexPath]];
    
}

@end
