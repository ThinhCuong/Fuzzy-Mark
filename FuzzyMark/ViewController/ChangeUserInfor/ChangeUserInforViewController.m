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
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    [self setNavigationBar];
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
    
    TNCircularCheckBoxData *femaleData = [[TNCircularCheckBoxData alloc] init];
    femaleData.identifier = @"male";
    femaleData.labelText = @"Nữ";
    femaleData.labelFont = [UIFont setFontMuliWithSize:14];
    femaleData.checked = NO;
    femaleData.borderColor = [UIColor colorWithRed:0.2 green:0.6 blue:0.86 alpha:1.0];
    femaleData.circleColor = [UIColor colorWithRed:0.2 green:0.6 blue:0.86 alpha:1.0];
    femaleData.borderRadius = 20;
    femaleData.circleRadius = 15;
    
    TNCheckBoxGroup *sex = [[TNCheckBoxGroup alloc] initWithCheckBoxData:@[maleData, femaleData] style:TNCheckBoxLayoutHorizontal];
    [sex create];
    sex.position = CGPointMake(0, 0);
    
    [self.checkBoxView addSubview:sex];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sexGroupChanged:) name:GROUP_CHANGED object:sex];
}

- (void)sexGroupChanged:(NSNotification *) notication {
    
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
