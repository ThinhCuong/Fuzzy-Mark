//
//  ChangeUserInforViewController.m
//  FuzzyMark
//
//  Created by Tu Tran on 5/17/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import "ChangeUserInforViewController.h"
#import <TLFloatLabelTextField-Swift.h>
#import "BEMCheckBox.h"

@interface ChangeUserInforViewController () <BEMCheckBoxDelegate>
@property (weak, nonatomic) IBOutlet TLFloatLabelTextField *txtName;
@property (weak, nonatomic) IBOutlet TLFloatLabelTextField *txtBirthday;
@property (weak, nonatomic) IBOutlet BEMCheckBox *CBMaleView;
@property (weak, nonatomic) IBOutlet BEMCheckBox *CBFemaleView;
@property (weak, nonatomic) IBOutlet UIButton *btnSave;

@end

@implementation ChangeUserInforViewController {
    BEMCheckBoxGroup *_groupSex;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    [self setNavigationBar];
}

- (void)setUI {
    // Set shadow button Save
    self.btnSave.layer.cornerRadius = 10;
    self.btnSave.clipsToBounds = YES;
    self.btnSave.layer.masksToBounds = NO;
    self.btnSave.layer.shadowOffset = CGSizeMake(0, 5);
    self.btnSave.layer.shadowColor = [UIColor colorWithRed:0.31 green:0.72 blue:1.0 alpha:0.3].CGColor;
    self.btnSave.layer.shadowRadius = 5;
    self.btnSave.layer.shadowOpacity = 1.0;
    
    self.CBMaleView.delegate = self;
    self.CBFemaleView.delegate = self;
    _groupSex = [BEMCheckBoxGroup groupWithCheckBoxes:@[self.CBMaleView,self.CBFemaleView]];
    _groupSex.mustHaveSelection = YES;
    
    self.txtBirthday.
}

- (void)setNavigationBar {
    self.navigationItem.title = @"Thông tin cá nhân";
    self.navigationController.navigationBar.topItem.title = @"";
    self.isHideNavigationBar = NO;
}

@end
