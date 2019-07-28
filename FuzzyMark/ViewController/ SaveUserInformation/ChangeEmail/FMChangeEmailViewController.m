//
//  FMChangeEmailViewController.m
//  FuzzyMark
//
//  Created by Tu Tran on 5/19/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import "FMChangeEmailViewController.h"

@interface FMChangeEmailViewController ()

@end

@implementation FMChangeEmailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setNavigationBar];
}

- (void)setNavigationBar {
    self.navigationItem.title = @"Cập nhật Email";
    self.navigationController.navigationBar.topItem.title = @"";
    self.isHideNavigationBar = NO;
}

@end
