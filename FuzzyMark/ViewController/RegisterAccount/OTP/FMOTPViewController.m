//
//  FMOTPChangeEmailViewController.m
//  FuzzyMark
//
//  Created by Tu Tran on 5/19/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import "FMOTPViewController.h"
#import "FuzzyMark-Swift.h"

@interface FMOTPViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet TJTextField *tfFirst;
@property (weak, nonatomic) IBOutlet TJTextField *tfSecond;
@property (weak, nonatomic) IBOutlet TJTextField *tfThird;
@property (weak, nonatomic) IBOutlet TJTextField *tfFourth;
@property (weak, nonatomic) IBOutlet UIButton *btnTime;
@property (weak, nonatomic) IBOutlet UIButton *btnSuccess;
@property (weak, nonatomic) IBOutlet UILabel *lbContent;
@property (weak, nonatomic) IBOutlet UILabel *lbTitle;
@property (assign, nonatomic) OTPType type;

@end

@implementation FMOTPViewController {
    NSAttributedString *_attributedString;
    NSString *_email;
    NSString *_typeString;
    NSTimer *_timer;
    NSInteger _currSeconds;
    NSString *_title;
    BaseCallApi *_httpClient;
}

#pragma mark - life cycle
- (instancetype)initWithTitleAttributedString:(NSAttributedString *) attributedString EmailSendOTP:(NSString *) email withType:(OTPType) type {
    self = [super init];
    if (self) {
        _type = type;
        _attributedString = attributedString;
        _email = email;
        switch (type) {
            case OTPTypeRegister:
                _typeString = @"REGISTER";
                _title = @"ĐĂNG KÍ";
                break;
            case OTPTypeReset:
                _typeString = @"RESET";
                _title = @"QUÊN MẬT KHẨU";
                break;
            default:
                _typeString = @"";
                _title = @"";
                break;
        }
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [_tfFirst addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [_tfSecond addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [_tfThird addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [_tfFourth addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    _lbContent.attributedText = _attributedString.length > 0 ? _attributedString : 0;
    _httpClient = [BaseCallApi defaultInitWithBaseURL];
    _lbTitle.text = _title;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.hideBottomLineNav = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.clipsToBounds = NO;
}

- (void)textFieldDidChange:(UITextField *) sender {
    if (![sender isKindOfClass:TJTextField.class]) {
        return;
    }
    _btnSuccess.enabled = [self validateTextField];
    TJTextField *textField = (TJTextField *) sender;
    if (textField.text.length > 0) {
        textField.lineColor = klineColorSuccess;
        [self nextTextFieldWithOldTextField:textField];
    } else {
        textField.lineColor = klineColorError;
    }
}

- (BOOL)validateTextField {
    BOOL isSuccessTFFirst = _tfFirst.text.length > 0;
    BOOL isSuccessTFSecond = _tfSecond.text.length > 0;
    BOOL isSuccessTFThird = _tfThird.text.length > 0;
    BOOL isSuccessTFFourth = _tfFourth.text.length > 0;
    if (isSuccessTFFirst && isSuccessTFSecond && isSuccessTFThird && isSuccessTFFourth) {
        return YES;
    }
    return NO;
}

- (void)nextTextFieldWithOldTextField:(UITextField *) oldTextField {
    if ([oldTextField isEqual:_tfFirst]) {
        [_tfSecond becomeFirstResponder];
    } else if ([oldTextField isEqual:_tfSecond]) {
        [_tfThird becomeFirstResponder];
    } else if ([oldTextField isEqual:_tfThird]) {
        [_tfFourth becomeFirstResponder];
    }
}

#pragma mark - IBAction
- (IBAction)didSelectBtnSendOTP:(id)sender {
    NSMutableString *otpString = [NSMutableString stringWithFormat:@"%@%@%@%@", _tfFirst.text, _tfSecond.text, _tfThird.text, _tfFourth.text];
    NSDictionary *params = @{@"otp": otpString ?: @"",
                             @"email": _email ?: @"",
                             @"type": _typeString ?: @""
                             };
    [CommonFunction showLoadingView];
    [_httpClient postDataWithPath:POST_USER_CHECK_OTP andParam:params isShowfailureAlert:YES withSuccessBlock:^(id success) {
        [CommonFunction hideLoadingView];
        if ([success isKindOfClass:NSDictionary.class]) {
            if([success codeForKey:@"error_code"] == 0) {
                [self.view endEditing:YES];
                if (self->_type == OTPTypeRegister) {
                    UserInformation *userInfo = [[UserInformation alloc] initWithDict:[success dictionaryForKey:@"data"]];
                    [self saveDataLoginSuccess:userInfo];
                } else {
                    [CommonFunction showToast:[success stringForKey:@"message"]];
                }
                if ([self.delegate respondsToSelector:@selector(checkOTPSuccess:withEmail:)]) {
                    [self.delegate checkOTPSuccess:YES withEmail:self->_email];
                }
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

- (IBAction)didSelectBtnResendOTP:(id)sender {
    NSDictionary *params = @{@"type": _typeString ?:@"",
                             @"email": _email ?: @""
                             };
    [CommonFunction showLoadingView];
    [_httpClient postDataWithPath:POST_USER_RESEND_OTP andParam:params isShowfailureAlert:YES withSuccessBlock:^(id success) {
        [CommonFunction hideLoadingView];
        if ([success isKindOfClass:NSDictionary.class]) {
            if([success codeForKey:@"error_code"] == 0) {
                self.lbContent.attributedText = self->_attributedString;
                [self startCountdownTime];
            } else {
                self.lbContent.attributedText = [self getAttributedErrorWithString:[success stringForKey:@"message"]];
            }
        } else {
            self.lbContent.attributedText = [self getAttributedErrorWithString:kMessageError];
        }
    } withFailBlock:^(id fail) {
        [CommonFunction hideLoadingView];
        self.lbContent.attributedText = [self getAttributedErrorWithString:kMessageError];
    }];
}

- (NSAttributedString *)getAttributedErrorWithString:(NSString *) text {
    NSAttributedString *errorAttributedText = [[NSAttributedString alloc] initWithString:text attributes:@{NSForegroundColorAttributeName : klineColorError}];
    return errorAttributedText;
}

#pragma mark - Countdownt Timer
- (void)startCountdownTime {
    _currSeconds = 60;
    _btnTime.enabled = NO;
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateCountdown) userInfo:nil repeats:YES];
}

- (void)updateCountdown {
    _currSeconds--;
    if (_currSeconds == 0) {
        [_btnTime setTitle:@"Gửi lại" forState:UIControlStateNormal];
        [self stopCountdown];
        return;
    } else {
        [_btnTime setTitle:[NSString stringWithFormat:@"Gửi lại (%ld%@)", (long)_currSeconds, @"s"] forState:UIControlStateDisabled];
    }
}

- (void)stopCountdown {
    _btnTime.enabled = YES;
    [_timer invalidate];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString *newText = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if (newText.length > 1) {
        return NO;
    }
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    textField.text = @"";
    if ([textField isKindOfClass:[TJTextField class]]) {
        TJTextField *lineTextField = (TJTextField *) textField;
        lineTextField.lineColor = klineColorError;
    }
    return YES;
}

- (void)saveDataLoginSuccess:(UserInformation *) userInfo {
    [UserInfo setUserInforWithUserModel:userInfo];
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationCenterChangeStatusUser object:nil];
    NSLog(@"token:JWT %@",userInfo.token);
}

@end
