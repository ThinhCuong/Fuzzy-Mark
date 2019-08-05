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
#import "FMInputEmailVC.h"
#import "FMLoginAccountViewController.h"
#import "FMLoginCell.h"
#import "FMChoicePictureModel.h"
#import "FMChangePasswordViewController.h"
#import "FMIntroChangePhoneNumber.h"

@interface FMUserInforViewController () <UITableViewDelegate, UITableViewDataSource, FMUserInforTableViewCellProtocol, FMUserInforDelegate, FMLoginCellDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableViewContent;
@property (strong, nonatomic) FMUserInforModel *model;
@end

@implementation FMUserInforViewController {
    NSArray <NSArray *> *_listMenuBlock;
    UserInformation *_userInfo;
    FMChoicePictureModel *modelImg;
}

#pragma mark - lifeCycle
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self) {
        self.model = [[FMUserInforModel alloc] init];
        self.model.delegate = self;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.hideNav = YES;
    [self setTableViewContent];
    [self.model loadData];
}

#pragma mark - private
- (void)setTableViewContent {
    self.tableViewContent.delegate = self;
    self.tableViewContent.dataSource = self;
    [self.tableViewContent registerNib:[UINib nibWithNibName:@"FMUserInforTableViewCell" bundle:nil] forCellReuseIdentifier:@"cellUser"];
    [self.tableViewContent registerNib:[UINib nibWithNibName:@"FMMenuTabbleViewCell" bundle:nil] forCellReuseIdentifier:@"cellMenu"];
    [self.tableViewContent registerNib:[UINib nibWithNibName:@"FMLoginCell" bundle:nil] forCellReuseIdentifier:@"cellLogin"];
    self.tableViewContent.contentInset = UIEdgeInsetsMake(0, 0, 20, 0);
}

- (void)reLoadBlockCell:(NSArray *) listMenuBlock {
    _listMenuBlock = listMenuBlock;
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(1, 2)];
    [self reloadTableViewWithIndexSet:indexSet];
}

- (void)reLoadUserCell:(UserInformation *) userInfo {
    _userInfo = userInfo;
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:0];
    [self reloadTableViewWithIndexSet:indexSet];
}

- (void)reloadTableViewWithIndexSet:(NSIndexSet *) indexSet {
    [_tableViewContent beginUpdates];
    [_tableViewContent reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
    [_tableViewContent endUpdates];
    [_tableViewContent selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:0 scrollPosition:UITableViewScrollPositionTop];
}

- (void)showToastInviteLogin {
    [CommonFunction showToast:@"Đăng nhập để sử dụng tính năng này"];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 2;
    } else if (section == 1) {
        return _listMenuBlock[0].count;
    } else if (section == 2) {
        return _listMenuBlock[1].count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return [self cellUserTableViewAtIndexPath:indexPath];
        } else if (indexPath.row == 1 && !isLoggedIn) {
            return [self cellLoginTableViewAtIndexPath:indexPath];
        }
    } else if (indexPath.section == 1 || indexPath.section == 2) {
        return [self cellMenuTableViewAtIndexPath:indexPath];
    }
    return [UITableViewCell new];
}

- (UITableViewCell *)cellLoginTableViewAtIndexPath:(NSIndexPath *) indexPath {
    // Show Login
    FMLoginCell *cell = [_tableViewContent dequeueReusableCellWithIdentifier:@"cellLogin"];
    cell.delegate = self;
    return cell;
}

- (UITableViewCell *)cellUserTableViewAtIndexPath:(NSIndexPath *) indexPath {
    FMUserInforTableViewCell *cell = [_tableViewContent dequeueReusableCellWithIdentifier:@"cellUser"];
    if (!isLoggedIn) {
        [cell binDataNotLogin];
    } else {
        [cell binDataLoginWithUserInfor:_userInfo];
    }
    cell.delegate = self;
    
    return cell;
}

- (UITableViewCell *)cellMenuTableViewAtIndexPath:(NSIndexPath *) indexPath {
    NSInteger indexArray = indexPath.section - 1;
    NSInteger indexItem = indexPath.row;
    FMMenuTabbleViewCell *cell = [_tableViewContent dequeueReusableCellWithIdentifier:@"cellMenu"];
    [cell binDataWith:_listMenuBlock[indexArray][indexItem]];
    
    // Ẩn bottom line với cell cuối
    if (indexPath.row == _listMenuBlock[indexArray].count - 1) {
        cell.hideBotomLine = YES;
    } else {
        cell.hideBotomLine = NO;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row == 1 && _userInfo) {
        return 16;
    }
    return UITableViewAutomaticDimension;
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
        return 8;
    }
    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01f;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    // Click Cell User
    if(indexPath.section == 0) {
        return;
    }
    // Click Cell Block
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self didSelectBlockCell:[tableView cellForRowAtIndexPath:indexPath]];
}

- (void)didSelectBlockCell:(FMMenuTabbleViewCell *) cell {
    if(![cell isKindOfClass:FMMenuTabbleViewCell.class]) {
        return;
    }
    switch (cell.typeBlock) {
        case FMTableViewCellBlockFavoritePlaces: {
            [self showViewFavorite];
            break;
        }
        case FMTableViewCellBlockUserInfor: {
            [self showViewChangeUserInfo];
            break;
        }
        case FMTableViewCellBlockChangePassWord:
            [self showViewChangePassword];
            break;
        case FMTableViewCellBlockChangePhoneNumber:
            [self showViewChangePhoneNumber];
            break;
        case FMTableViewCellBlockPoliciesAndTerms:
            
            break;
        case FMTableViewCellBlockLogOut:
            [UserInfo resetUserData];
            [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationCenterChangeStatusUser object:nil];
            break;
        default:
            break;
    }
}

#pragma mark - FMUserInforTableViewCellProtocol
- (void)didSelectButtonHistory {
    if (!isLoggedIn) {
        [self showToastInviteLogin];
        return;
    }
    FMHistoryBillViewController *vc = [[FMHistoryBillViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didSelectButtonPoint {
    if (!isLoggedIn) {
        [self showToastInviteLogin];
        return;
    }
    FMHistoryPointViewController *vc = [[FMHistoryPointViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didSelectButtonAddImageUser {
    if (!isLoggedIn) {
        [self showToastInviteLogin];
        return;
    }
    if (!modelImg) {
        modelImg = [[FMChoicePictureModel alloc] init];
    }
    __block FMUserInforViewController *blockSelf = self;
    [modelImg showOptionsCameraAndLibrary:self selectedImage:^(id _Nonnull selectedImg) {
        if(selectedImg) {
            [blockSelf.model uploadAvatar:selectedImg withSuccessBlock:^(BOOL isSuccess) {
                if (isSuccess) {
                    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:0];
                    [self reloadTableViewWithIndexSet:indexSet];
                }
            }];
        }
    }];
}

- (void)didSelectEmailView {
    return;
}

- (void)didSelectPhoneView {
    if (!isLoggedIn) {
        [self showToastInviteLogin];
        return;
    }
    
}

#pragma mark - FMLoginCellDelegate
- (void)didSelectLogin {
    FMLoginAccountViewController *vc = [[FMLoginAccountViewController alloc] init];
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:navi animated:YES completion:nil];
}

#pragma mark - Goto ViewController
- (void)showViewFavorite {
    if (!isLoggedIn) {
        [self showToastInviteLogin];
        return;
    }
    FMLocationFavoriteViewController *vc = [[FMLocationFavoriteViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)showViewChangeUserInfo {
    if (!isLoggedIn) {
        [self showToastInviteLogin];
        return;
    }
    FMChangeUserInforViewController *vc = [[FMChangeUserInforViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)showViewChangePassword {
    FMChangePasswordViewController *vc = [[FMChangePasswordViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)showViewChangePhoneNumber {
    FMIntroChangePhoneNumber *vc = [[FMIntroChangePhoneNumber alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
