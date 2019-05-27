//
//  ChangeUserInforViewController.m
//  FuzzyMark
//
//  Created by Tu Tran on 5/17/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import "ChangeUserInforViewController.h"
#import "FuzzyMark-Swift.h"
#import "BEMCheckBox.h"

@interface ChangeUserInforViewController () <BEMCheckBoxDelegate>
@property (weak, nonatomic) IBOutlet TJTextField *txtName;
@property (weak, nonatomic) IBOutlet TJTextField *txtBirthday;
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
    self.CBMaleView.delegate = self;
    self.CBFemaleView.delegate = self;
    _groupSex = [BEMCheckBoxGroup groupWithCheckBoxes:@[self.CBMaleView,self.CBFemaleView]];
    _groupSex.mustHaveSelection = YES;
    
//    [self hideDatePicker];
}

- (void)setNavigationBar {
    self.navigationItem.title = @"Thông tin cá nhân";
    self.navigationController.navigationBar.topItem.title = @"";
    self.isHideNavigationBar = NO;
}

#pragma mark - IBAction
- (IBAction)didSelectChangeBirthday:(id)sender {
//    [self showDatePicker];
}

- (IBAction)didSelectSave:(id)sender {
    
}

- (IBAction)didSelectCancle:(id)sender {
//    [self hideDatePicker];
}

//#pragma mark - private
//- (void)showDatePicker {
//    [UIView animateWithDuration:0.3 animations:^{
//        self.viewDatePicker.hidden = NO;
//    }];
//}
//
//- (void)hideDatePicker {
//    [UIView animateWithDuration:0.3 animations:^{
//        self.viewDatePicker.hidden = YES;
//    }];
//}


@end
