//
//  ChangeUserInforViewController.m
//  FuzzyMark
//
//  Created by Tu Tran on 5/17/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import "FMChangeUserInforViewController.h"
#import "FMChangeEmailViewController.h"
#import "FuzzyMark-Swift.h"
#import "FMCheckBoxGroup.h"

@interface FMChangeUserInforViewController ()
@property (weak, nonatomic) IBOutlet TJTextField *txtName;
@property (weak, nonatomic) IBOutlet TJTextField *txtBirthday;
@property (weak, nonatomic) IBOutlet UIButton *btnSave;
@property (weak, nonatomic) IBOutlet UIView *checkBoxView;


@end

@implementation FMChangeUserInforViewController {
    TNCircularCheckBoxData *_selectCheckBox;
    FMCheckBoxGroup *_sexGroup;
    UIDatePicker *_datePicker;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setNavigationBar];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidAppear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setUI {
    [self setCheckBox];
    [self setDatePicker];
}

- (void)setCheckBox {
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

- (void)setDatePicker {
    // Set DatePicker nhỏ nhất 16 tuổi lớn nhất 150 tuổi
    _datePicker = [[UIDatePicker alloc] init];
    _datePicker.datePickerMode = UIDatePickerModeDate;
    _datePicker.backgroundColor = UIColor.whiteColor;
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate *currentDate = [NSDate date];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setYear:-16];
    NSDate *maxDate = [gregorian dateByAddingComponents:comps toDate:currentDate  options:0];
    [comps setYear:-150];
    NSDate *minDate = [gregorian dateByAddingComponents:comps toDate:currentDate  options:0];
    _datePicker.minimumDate = minDate;
    _datePicker.maximumDate = maxDate;
    [self.txtBirthday setInputView:_datePicker];
    
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    [toolBar setTintColor:UIColor.whiteColor];
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(didSelectDoneDatePicker)];
    [doneBtn setTintColor:[UIColor colorWithRed:0.2 green:0.6 blue:0.86 alpha:1.0]];
    UIBarButtonItem *cancleBtn = [[UIBarButtonItem alloc] initWithTitle:@"Huỷ" style:UIBarButtonItemStyleDone target:self action:@selector(didSelectCancleDatePicker)];
    [cancleBtn setTintColor:[UIColor colorWithRed:0.01 green:0.01 blue:0.01 alpha:1.0]];
    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [toolBar setItems:[NSArray arrayWithObjects:space, doneBtn, cancleBtn, nil]];
    [self.txtBirthday setInputAccessoryView:toolBar];
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
- (IBAction)didSelectSave:(id)sender {
    FMChangeEmailViewController *vc = [[FMChangeEmailViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - private
- (void)didSelectDoneDatePicker {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];
    self.txtBirthday.text = [dateFormatter stringFromDate:_datePicker.date];
    [self.txtBirthday resignFirstResponder];
}

- (void)didSelectCancleDatePicker {
    [self.txtBirthday resignFirstResponder];
}


@end
