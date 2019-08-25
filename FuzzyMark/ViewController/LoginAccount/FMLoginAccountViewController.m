//
//  FMLoginAccountViewController.m
//  FuzzyMark
//
//  Created by Tu Tran on 7/28/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import "FMLoginAccountViewController.h"
#import "FuzzyMark-Swift.h"
#import "UserInformation.h"
#import "FMInputEmailVC.h"
#import "FMOTPViewController.h"
#import "FMRegisterAccountViewController.h"
#import "FMForgotPasswordVC.h"

@interface FMLoginAccountViewController () <UITextFieldDelegate, FMInputEmailVCDelegate, FMOTPViewControllerDelegate>
@property (weak, nonatomic) IBOutlet TJTextField *tfName;
@property (weak, nonatomic) IBOutlet TJTextField *tfPassword;
@property (weak, nonatomic) IBOutlet UIButton *btnSuccess;
@end

@implementation FMLoginAccountViewController {
    BaseCallApi *_httpClient;
    LoginType _type;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.hideBottomLineNav = YES;
    [self.tfName addTarget:self action:@selector(textfieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.tfPassword addTarget:self action:@selector(textfieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    _httpClient = [BaseCallApi defaultInitWithBaseURL];
}

- (BOOL)validatePasswordWithString:(NSString *) password {
//    NSString *passwordRegex = @"^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[$@$!%*?&])[A-Za-z\\d$@$!%*?&]{10,}";
//    NSPredicate *passwordTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", passwordRegex];
//    return [passwordTest evaluateWithObject:password];
    return YES;
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
    NSLog(@"token:JWT %@",userInfo.token);
}

#pragma mark - IBAction
- (IBAction)didSelectBtnClose:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)didSelectBtnSuccess:(id)sender {
    _type = LoginTypeSignIn;
    NSDictionary *params = @{@"email": _tfName.text ?: @"",
                             @"password": _tfPassword.text ?: @"",
                             @"device_id": [UserInfo getDeviceID],
                             @"device_type": @1
                             };
    [CommonFunction showLoadingView];
    [_httpClient postDataWithPath:POST_USER_LOGIN andParam:params isShowfailureAlert:YES withSuccessBlock:^(id success) {
        [CommonFunction hideLoadingView];
        if ([success isKindOfClass:[NSDictionary class]]) {
            if ([success codeForKey:@"error_code"] == 0) {
                UserInformation *userInfo = [[UserInformation alloc] initWithDict:[success dictionaryForKey:@"data"]];
                [self saveDataLoginSuccess:userInfo];
                [self dismissViewControllerAnimated:YES completion:^{
                    self.loginSuccess ? self.loginSuccess(YES) : 0;
                }];
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

- (IBAction)didSelectRegister:(id)sender {
    UserInformation *user = [[UserInformation alloc] init];
    user.user_view = [[UseView alloc] init];
    FMRegisterAccountViewController *vc = [[FMRegisterAccountViewController alloc] initWithUser:user];
    vc.registerSuccess = ^{
        [self dismissViewControllerAnimated:YES completion:nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationCenterChangeStatusUser object:nil];
        self.loginSuccess ? self.loginSuccess(YES) : 0;
    };
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)didSelectForgotPassword:(id)sender {
    _type = LoginTypeForgotPassword;
    FMInputEmailVC *vc = [[FMInputEmailVC alloc] initWithType:_type];
    vc.delegate = self;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:nil];
}

#pragma mark - FMInputEmailVCDelegate
- (void)outputEmailSuccess:(NSString *)email {
    if (_type == LoginTypeSignUp) {
        [self showOTPSignUpWithEmail:email];
    } else if (_type == LoginTypeForgotPassword) {
        [self showOTPForgotPasswordWithEmail:email];
    }
}

- (void)showOTPSignUpWithEmail:(NSString *) email {
    NSAttributedString *emailString = [[NSAttributedString alloc] initWithString:email ?: @"" attributes:@{NSFontAttributeName : [UIFont setBoldFontMuliWithSize:14.0]}];
    NSAttributedString *titleString = [[NSAttributedString alloc] initWithString:@"Vui lòng nhập mã OTP vừa được gửi đến email " attributes:@{NSFontAttributeName : [UIFont setFontMuliWithSize:14.0]}];
    NSMutableAttributedString *titleAttributedString = [[NSMutableAttributedString alloc] initWithAttributedString:titleString];
    [titleAttributedString appendAttributedString:emailString];
    
    FMOTPViewController *vc = [[FMOTPViewController alloc] initWithTitleAttributedString:titleAttributedString EmailSendOTP:email ?: @"" withType:OTPTypeRegister];
    vc.delegate = self;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)showOTPForgotPasswordWithEmail:(NSString *) email {
    NSAttributedString *titleString = [[NSAttributedString alloc] initWithString:@"Nhập dãy 4 chữ số vừa được gửi vào email cho bạn để xác nhận" attributes:@{NSFontAttributeName : [UIFont setFontMuliWithSize:14.0]}];
    
    FMOTPViewController *vc = [[FMOTPViewController alloc] initWithTitleAttributedString:titleString EmailSendOTP:email ?: @"" withType:OTPTypeReset];
    vc.delegate = self;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - FMOTPViewControllerDelegate
- (void)checkOTPSuccess:(BOOL)isSuccess withEmail:(NSString *)email {
    // Register Account or Forgot Password
    if (isSuccess) {
        UserInformation *user = [[UserInformation alloc] init];
        user.user_view = [[UseView alloc] init];
        user.email = email ?: @"";
        
        if (_type == LoginTypeSignUp) {
            FMRegisterAccountViewController *vc = [[FMRegisterAccountViewController alloc] initWithUser:user];
            vc.registerSuccess = ^{
                [self dismissViewControllerAnimated:YES completion:nil];
                [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationCenterChangeStatusUser object:nil];
                self.loginSuccess ? self.loginSuccess(YES) : 0;
            };
            [self.navigationController pushViewController:vc animated:YES];
        } else if (_type == LoginTypeForgotPassword) {
            FMForgotPasswordVC *vc = [[FMForgotPasswordVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}

@end
