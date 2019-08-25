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

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navTitle = @"Thông tin cá nhân";
    [self setUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.hideBottomLineNav = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.clipsToBounds = NO;
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidAppear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setUI {
    [self setCheckBox];
    [self setDatePicker];
}

- (NSString *)converDate:(NSString *) dateString {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];
    NSDate *date = [dateFormatter dateFromString:dateString];
    [dateFormatter setDateFormat:@"yyyy-mm-dd"];
    return [dateFormatter stringFromDate:date];
}

#pragma mark - IBAction
- (IBAction)didSelectSave:(id)sender {
    BaseCallApi *httpClient = [BaseCallApi defaultInitWithBaseURL];
    NSDictionary *param = @{@"full_name": _txtName.text ?:@"",
                            @"gender": _selectCheckBox.identifier ?:@"",
                            @"birthday": [self converDate:_txtBirthday.text] ?:@""
                            };
    [CommonFunction showLoadingView];
    [httpClient putDataWithPath:PUT_USER_UPDATE_PROFILE andParam:param isSendToken:YES isShowfailureAlert:YES withSuccessBlock:^(id _Nullable success) {
        [CommonFunction hideLoadingView];
        if ([success isKindOfClass:NSDictionary.class]) {
            if ([success codeForKey:@"error_code"] == 0) {
                [self.navigationController popToRootViewControllerAnimated:YES];
                [CommonFunction showToast:[success stringForKey:@"message"]];
            } else {
                [CommonFunction showToast:[success stringForKey:@"message"]];
            }
        } else {
            [CommonFunction showToast:kMessageError];
        }
    } withFailBlock:^(id _Nullable fail) {
        [CommonFunction hideLoadingView];
        [CommonFunction showToast:kMessageError];
    }];
}

- (void)setCheckBox {
    TNCircularCheckBoxData *maleData = [[TNCircularCheckBoxData alloc] init];
    maleData.identifier = @"1";
    maleData.labelText = @"Nam";
    maleData.checked = YES;
    maleData.borderColor = [UIColor colorWithRed:0.2 green:0.6 blue:0.86 alpha:1.0];
    maleData.circleColor = [UIColor colorWithRed:0.2 green:0.6 blue:0.86 alpha:1.0];
    maleData.borderRadius = 15;
    maleData.circleRadius = 10;
    _selectCheckBox = maleData;
    
    TNCircularCheckBoxData *femaleData = [[TNCircularCheckBoxData alloc] init];
    femaleData.identifier = @"2";
    femaleData.labelText = @"Nữ";
    femaleData.checked = NO;
    femaleData.borderColor = [UIColor colorWithRed:0.2 green:0.6 blue:0.86 alpha:1.0];
    femaleData.circleColor = [UIColor colorWithRed:0.2 green:0.6 blue:0.86 alpha:1.0];
    femaleData.borderRadius = 15;
    femaleData.circleRadius = 10;
    
    _sexGroup = [[FMCheckBoxGroup alloc] initWithCheckBoxData:@[maleData, femaleData] style:TNCheckBoxLayoutHorizontal];
    [_sexGroup create];
    _sexGroup.position = CGPointMake(0, 5);
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
