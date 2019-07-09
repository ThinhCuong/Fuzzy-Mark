//
//  ChangeUserInforViewController.m
//  FuzzyMark
//
//  Created by Tu Tran on 5/17/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import "FMChangeUserInforViewController.h"
#import "FuzzyMark-Swift.h"
#import "FMCheckBoxGroup.h"
#import "TNCheckBox+SingleSelect.h"

@interface FMChangeUserInforViewController ()
@property (weak, nonatomic) IBOutlet TJTextField *txtName;
@property (weak, nonatomic) IBOutlet TJTextField *txtBirthday;
@property (weak, nonatomic) IBOutlet UIButton *btnSave;
@property (weak, nonatomic) IBOutlet UIView *checkBoxView;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;


@end

@implementation FMChangeUserInforViewController {
    TNCircularCheckBoxData *_selectCheckBox;
    FMCheckBoxGroup *_sexGroup;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    [self setNavigationBar];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidAppear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setUI {
    TNCircularCheckBoxData *maleData = [[TNCircularCheckBoxData alloc] init];
    maleData.identifier = @"male";
    maleData.labelText = @"Nam";
    maleData.labelFont = [UIFont setFontMuliWithSize:14];
    maleData.checked = YES;
    maleData.borderColor = [UIColor colorWithRed:0.2 green:0.6 blue:0.86 alpha:1.0];
    maleData.circleColor = [UIColor colorWithRed:0.2 green:0.6 blue:0.86 alpha:1.0];
    maleData.borderRadius = 20;
    maleData.circleRadius = 15;
    _selectCheckBox = maleData;
    
    TNCircularCheckBoxData *femaleData = [[TNCircularCheckBoxData alloc] init];
    femaleData.identifier = @"female";
    femaleData.labelText = @"Nữ";
    femaleData.labelFont = [UIFont setFontMuliWithSize:14];
    femaleData.checked = NO;
    femaleData.borderColor = [UIColor colorWithRed:0.2 green:0.6 blue:0.86 alpha:1.0];
    femaleData.circleColor = [UIColor colorWithRed:0.2 green:0.6 blue:0.86 alpha:1.0];
    femaleData.borderRadius = 20;
    femaleData.circleRadius = 15;
    
    _sexGroup = [[FMCheckBoxGroup alloc] initWithCheckBoxData:@[maleData, femaleData] style:TNCheckBoxLayoutHorizontal];
    [_sexGroup create];
    _sexGroup.position = CGPointMake(0, 0);
    [self.checkBoxView addSubview:_sexGroup];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sexGroupChanged:) name:GROUP_CHANGED object:_sexGroup];
}

- (void)sexGroupChanged:(NSNotification *)notification {
    _selectCheckBox = _sexGroup.checkedCheckBoxes[0];
}

- (void)setNavigationBar {
    self.navigationItem.title = @"Thông tin cá nhân";
    self.navigationController.navigationBar.topItem.title = @"";
    self.isHideNavigationBar = NO;
}

#pragma mark - IBAction
- (IBAction)didSelectChangeBirthday:(id)sender {
    [self showDatePicker];
}

- (IBAction)didSelectSave:(id)sender {
    
}

- (IBAction)didSelectCancle:(id)sender {
//    [self hideDatePicker];
}

#pragma mark - private
- (void)showDatePicker {
    if(!self.datePicker.hidden) {
        return;
    }
    [UIView animateWithDuration:0.3 animations:^{
        self.datePicker.hidden = NO;
    }];
}

- (void)hideDatePicker {
    if(self.datePicker.hidden) {
        return;
    }
    [UIView animateWithDuration:3 animations:^{
        self.datePicker.hidden = YES;
    }];
}


@end
