//
//  FMForgotPasswordVC.m
//  FuzzyMark
//
//  Created by Tu Tran on 7/28/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import "FMForgotPasswordVC.h"

@interface FMForgotPasswordVC ()

@end

@implementation FMForgotPasswordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setNavigationBar];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.clipsToBounds = NO;
}

- (void)setNavigationBar {
    self.navigationItem.title = @"";
    self.navigationController.navigationBar.topItem.title = @"";
    self.isHideNavigationBar = NO;
    self.navigationController.navigationBar.clipsToBounds = YES;
}




@end
