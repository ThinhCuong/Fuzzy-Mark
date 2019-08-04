//
//  FMBaseViewController.m
//  FuzzyMark
//
//  Created by Tu Tran on 5/1/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import "FMBaseViewController.h"

@interface FMBaseViewController ()

@end

@implementation FMBaseViewController {
    UITapGestureRecognizer *_tapCloseKeyboard;
    
}

#pragma mark - IBAction
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self resetNavigation];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidHide:)
                                                 name:UIKeyboardDidHideNotification
                                               object:nil];
    _tapCloseKeyboard = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeKeyboart)];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidHideNotification object:nil];
}

#pragma mark - private
- (void)resetNavigation {
    self.hideBottomLineNav = _hideBottomLineNav;
    self.hideNav = _hideNav;
    self.navBackBtnTitle = _navBackBtnTitle ?: @"";
    self.navTitle = _navTitle ?: @"";
}

- (void)closeKeyboart {
    [self.view endEditing:YES];
}

- (void)keyboardDidShow: (NSNotification *) notif{
    [self.view addGestureRecognizer:_tapCloseKeyboard];
}

- (void)keyboardDidHide: (NSNotification *) notif{
    [self.view removeGestureRecognizer:_tapCloseKeyboard];
}

#pragma mark - Accessory
- (void)setNavTitle:(NSString *)navTitle {
    _navTitle = navTitle;
    [self.navigationItem setTitle:self.navTitle ?: @""];
}

- (void)setHideNav:(BOOL)hideNav {
    _hideNav = hideNav;
    [self.navigationController setNavigationBarHidden:hideNav];
}

- (void)setNavBackBtnTitle:(NSString *)navBackBtnTitle {
    _navBackBtnTitle = navBackBtnTitle;
    [self.navigationController.navigationBar.topItem setTitle:self.navBackBtnTitle ?: @""];
}

- (void)setHideBottomLineNav:(BOOL)hideBottomLineNav {
    _hideBottomLineNav = hideBottomLineNav;
    [self.navigationController.navigationBar setClipsToBounds:self.hideBottomLineNav];
}

@end
