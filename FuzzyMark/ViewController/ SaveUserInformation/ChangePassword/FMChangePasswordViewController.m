//
//  FMChangePasswordViewController.m
//  FuzzyMark
//
//  Created by Tu Tran on 5/19/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import "FMChangePasswordViewController.h"
#import "FuzzyMark-Swift.h"

@interface FMChangePasswordViewController ()
@property (weak, nonatomic) IBOutlet UITextField *tfOldpassword;
@property (weak, nonatomic) IBOutlet UITextField *tfNewpassword;
@property (weak, nonatomic) IBOutlet UITextField *tfRepassword;
@property (weak, nonatomic) IBOutlet UIButton *btnSave;
@property (weak, nonatomic) IBOutlet UIButton *btnShowNewpass;
@property (weak, nonatomic) IBOutlet UIButton *btnShowOldpass;
@end

@implementation FMChangePasswordViewController {
    UITapGestureRecognizer *_tapCloseKeyboard;
    BaseCallApi *_httpClient;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navTitle = @"Cập nhật mật khẩu";
    [self.tfOldpassword addTarget:self action:@selector(textfieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.tfNewpassword addTarget:self action:@selector(textfieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.tfRepassword addTarget:self action:@selector(textfieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    _httpClient = [BaseCallApi defaultInitWithBaseURL];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.hideNav = YES;
}

- (BOOL)validateNewPasswordWithString:(NSString *) password {
    NSString *passwordRegex = @"^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[$@$!%*?&])[A-Za-z\\d$@$!%*?&]{10,}";
    NSPredicate *passwordTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", passwordRegex];
    return [passwordTest evaluateWithObject:password];
}

- (BOOL)validateRepasswordWithString:(NSString *) repassword  {
    return [repassword isEqualToString:_tfNewpassword.text];
}

- (BOOL)validateOldPasswordWithString:(NSString *) oldpassword  {
    return oldpassword.length > 0;
}

- (BOOL)enableButtonSuccess {
    BOOL isValidateNewpassword = [self validateNewPasswordWithString:_tfNewpassword.text];
    BOOL isValidateRepassword = [self validateRepasswordWithString:_tfRepassword.text];
    BOOL isValidateOldPassword = [self validateOldPasswordWithString:_tfOldpassword.text];
    return (isValidateNewpassword && isValidateRepassword && isValidateOldPassword);
}

- (void)changeStateTextField:(UITextField *) sender {
    if (![sender isKindOfClass:TJTextField.class]) {
        return;
    }
    TJTextField *textField = (TJTextField *) sender;
    BOOL isValidateTF = false;
    if ([textField isEqual:_tfNewpassword]) {
        isValidateTF = [self validateNewPasswordWithString:_tfNewpassword.text];
    } else if ([textField isEqual:_tfRepassword]) {
        isValidateTF = [self validateRepasswordWithString:_tfRepassword.text];
    } else if ([textField isEqual:_tfOldpassword]) {
        isValidateTF = [self validateOldPasswordWithString:_tfOldpassword.text];
    }
    textField.lineColor = isValidateTF ? klineColorSuccess : klineColorError;
}

- (void)textfieldDidChange:(UITextField *) sender {
    [self changeStateTextField:sender];
    _btnSave.enabled = [self enableButtonSuccess];
}

- (IBAction)showTextWithTextField:(id)sender {
    if ([sender isEqual:_btnShowOldpass]) {
        if(_tfOldpassword.isSecureTextEntry) {
            _tfOldpassword.secureTextEntry = NO;
            [_btnShowOldpass setTitle:@"ẨN" forState:UIControlStateNormal];
        } else {
            _tfOldpassword.secureTextEntry = YES;
            [_btnShowOldpass setTitle:@"HIỆN" forState:UIControlStateNormal];
        }
    }
    
    if ([sender isEqual:_btnShowNewpass]) {
        if(_tfNewpassword.isSecureTextEntry) {
            _tfNewpassword.secureTextEntry = NO;
            [_btnShowNewpass setTitle:@"ẨN" forState:UIControlStateNormal];
        } else {
            _tfNewpassword.secureTextEntry = YES;
            [_btnShowNewpass setTitle:@"HIỆN" forState:UIControlStateNormal];
        }
    }
}

- (IBAction)saveNewpassword:(id)sender {
    NSDictionary *params = @{@"new_password": _tfNewpassword};
    [CommonFunction showLoadingView];
    [_httpClient postDataWithPath:@"user/change-password" andParam:params isShowfailureAlert:YES withSuccessBlock:^(id success) {
        [CommonFunction hideLoadingView];
        if ([success isKindOfClass:NSDictionary.class]) {
            if ([success codeForKey:@"error_code"] == 0) {
                [self.navigationController popToRootViewControllerAnimated:YES];
            } else {
                [CommonFunction showToast:[success stringForKey:@"message"]];
            }
        } else {
            [CommonFunction showToast:kMessageError];
        }
    } withFailBlock:^(id fail) {
        [CommonFunction hideLoadingView];
        [CommonFunction showToast:kMessageError];
    }];
}

@end
