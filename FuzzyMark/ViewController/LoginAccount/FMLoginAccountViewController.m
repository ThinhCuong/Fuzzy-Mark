//
//  FMLoginAccountViewController.m
//  FuzzyMark
//
//  Created by Tu Tran on 7/28/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import "FMLoginAccountViewController.h"
#import "FuzzyMark-Swift.h"
#import "NSDictionary+Helper.h"
#import "UserInformation.h"
#import "FMInputEmailVC.h"

@interface FMLoginAccountViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet TJTextField *tfName;
@property (weak, nonatomic) IBOutlet TJTextField *tfPassword;
@property (weak, nonatomic) IBOutlet UIButton *btnSuccess;
@end

@implementation FMLoginAccountViewController {
    BaseCallApi *_httpClient;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.tfName addTarget:self action:@selector(textfieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.tfPassword addTarget:self action:@selector(textfieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    _httpClient = [BaseCallApi defaultInitWithBaseURL];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setNavigationBar];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.clipsToBounds = NO;
}

#pragma mark - private
- (void)setNavigationBar {
    self.navigationItem.title = @"";
    self.navigationController.navigationBar.topItem.title = @"";
    self.isHideNavigationBar = NO;
    self.navigationController.navigationBar.clipsToBounds = YES;
}

- (BOOL)validatePasswordWithString:(NSString *) password {
    NSString *passwordRegex = @"^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[$@$!%*?&])[A-Za-z\\d$@$!%*?&]{10,}";
    NSPredicate *passwordTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", passwordRegex];
    return [passwordTest evaluateWithObject:password];
}

- (BOOL)validateEmailWithString:(NSString *) email {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

- (void)textfieldDidChange:(UITextField *) sender {
    [self changeStateTextField:sender];
    _btnSuccess.enabled = [self enableButtonSuccess];
}

- (void)changeStateTextField:(UITextField *) sender {
    if (![sender isKindOfClass:TJTextField.class]) {
        return;
    }
    TJTextField *textField = (TJTextField *) sender;
    BOOL isValidateTF;
    if([textField isEqual:_tfName]) {
        isValidateTF = [self validateEmailWithString:textField.text];
    } else {
        isValidateTF = [self validatePasswordWithString:textField.text];
    }
    textField.lineColor = isValidateTF ? klineColorSuccess : klineColorError;
}

- (BOOL)enableButtonSuccess {
    BOOL isValidaName = [self validateEmailWithString:_tfName.text];
    BOOL isValidaPassword = [self validatePasswordWithString:_tfPassword.text];
    return (isValidaName && isValidaPassword);
}

- (void)saveDataLoginSuccess:(UserInformation *) userInfo {
    [UserInfo setUserInforWithUserModel:userInfo];
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationCenterChangeStatusUser object:nil];
}

#pragma mark - IBAction
- (IBAction)didSelectBtnClose:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)didSelectBtnSuccess:(id)sender {
    NSDictionary *params = @{@"email": _tfName.text ?: @"",
                             @"password": _tfPassword.text ?: @"",
                             @"device_id": [UserInfo getDeviceID],
                             @"device_type": @1
                             };
    [CommonFunction showLoadingView];
    [_httpClient postDataWithPath:@"user/login" andParam:params isShowfailureAlert:YES withSuccessBlock:^(id success) {
        [CommonFunction hideLoadingView];
        if ([success isKindOfClass:[NSDictionary class]]) {
            if ([success codeForKey:@"error_code"] == 0) {
                UserInformation *userInfo = [[UserInformation alloc] initWithDictionary:[success dictionaryForKey:@"data"] error:nil];
                [self saveDataLoginSuccess:userInfo];
                [self dismissViewControllerAnimated:YES completion:nil];
            } else {
                [CommonFunction showToast:[success stringForKey:@"message"]];
            }
        } else {
            [CommonFunction showToast:@"Có lỗi xẩy ra vui lòng thử lại sau"];
        }
    } withFailBlock:^(id fail) {
        [CommonFunction hideLoadingView];
        [CommonFunction showToast:@"Có lỗi xẩy ra vui lòng thử lại sau"];
    }];
}

- (IBAction)didSelectRegister:(id)sender {
    FMInputEmailVC *vc = [[FMInputEmailVC alloc] init];
    vc.registerSuccess = ^{
        [self dismissViewControllerAnimated:YES completion:nil];
    };
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)didSelectForgotPassword:(id)sender {
    
}

@end
