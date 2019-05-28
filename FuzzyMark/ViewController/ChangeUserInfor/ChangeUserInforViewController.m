//
//  ChangeUserInforViewController.m
//  FuzzyMark
//
//  Created by Tu Tran on 5/17/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import "ChangeUserInforViewController.h"
#import "FuzzyMark-Swift.h"
#import <TNCheckBoxGroup/TNCheckBoxGroup.h>

@interface ChangeUserInforViewController ()
@property (weak, nonatomic) IBOutlet TJTextField *txtName;
@property (weak, nonatomic) IBOutlet TJTextField *txtBirthday;
@property (weak, nonatomic) IBOutlet UIButton *btnSave;
@property (weak, nonatomic) IBOutlet UIView *checkBoxView;


@end

@implementation ChangeUserInforViewController {
    TNCircularCheckBoxData *_maleData;
    TNCircularCheckBoxData *_femaleData;
    TNCheckBoxGroup *_sexGroup;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    [self setNavigationBar];
}

- (void)setUI {
    _maleData = [[TNCircularCheckBoxData alloc] init];
    _maleData.identifier = @"male";
    _maleData.labelText = @"Nam";
    _maleData.labelFont = [UIFont setFontMuliWithSize:14];
    _maleData.checked = YES;
    _maleData.borderColor = [UIColor colorWithRed:0.2 green:0.6 blue:0.86 alpha:1.0];
    _maleData.circleColor = [UIColor colorWithRed:0.2 green:0.6 blue:0.86 alpha:1.0];
    _maleData.borderRadius = 20;
    _maleData.circleRadius = 15;
    
    _femaleData = [[TNCircularCheckBoxData alloc] init];
    _femaleData.identifier = @"male";
    _femaleData.labelText = @"Nữ";
    _femaleData.labelFont = [UIFont setFontMuliWithSize:14];
    _femaleData.checked = NO;
    _femaleData.borderColor = [UIColor colorWithRed:0.2 green:0.6 blue:0.86 alpha:1.0];
    _femaleData.circleColor = [UIColor colorWithRed:0.2 green:0.6 blue:0.86 alpha:1.0];
    _femaleData.borderRadius = 20;
    _femaleData.circleRadius = 15;
    
    _sexGroup = [[TNCheckBoxGroup alloc] initWithCheckBoxData:@[_maleData, _femaleData] style:TNCheckBoxLayoutHorizontal];
    [_sexGroup create];
    _sexGroup.position = CGPointMake(0, 0);
//    _sexGroup.
    [self.checkBoxView addSubview:_sexGroup];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sexGroupChanged) name:GROUP_CHANGED object:nil];
}

- (void)sexGroupChanged {
//    _sexGroup.checkedCheckBoxes
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
