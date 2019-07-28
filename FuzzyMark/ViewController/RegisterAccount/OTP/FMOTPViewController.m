//
//  FMOTPChangeEmailViewController.m
//  FuzzyMark
//
//  Created by Tu Tran on 5/19/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import "FMOTPViewController.h"
#import "FuzzyMark-Swift.h"
#import "NSDictionary+Helper.h"

@interface FMOTPViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet TJTextField *tfFirst;
@property (weak, nonatomic) IBOutlet TJTextField *tfSecond;
@property (weak, nonatomic) IBOutlet TJTextField *tfThird;
@property (weak, nonatomic) IBOutlet TJTextField *tfFourth;
@property (weak, nonatomic) IBOutlet UIButton *btnTime;
@property (weak, nonatomic) IBOutlet UIButton *btnSuccess;
@property (weak, nonatomic) IBOutlet UILabel *lbTitle;

@end

@implementation FMOTPViewController {
    NSAttributedString *_attributedString;
    NSString *_email;
    NSString *_type;
    BaseCallApi *_httpClient;
}

#pragma mark - life cycle
- (instancetype)initWithTitleAttributedString:(NSAttributedString *) attributedString EmailSendOTP:(NSString *) email withType:(OTPType) type {
    self = [super init];
    if (self) {
        _attributedString = attributedString;
        _email = email;
        switch (type) {
            case OTPTypeRegister:
                _type = @"REGISTER";
                break;
            case OTPTypeReset:
                _type = @"RESET";
            default:
                _type = @"";
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
    _lbTitle.attributedText = _attributedString.length > 0 ? _attributedString : 0;
    _httpClient = [BaseCallApi defaultInitWithBaseURL];
    [self didSelectBtnResendOTP:nil];
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
    NSDictionary *params = @{@"otp": otpString,
                             @"email": _email ?: @""
                             };
    [CommonFunction showLoadingView];
    [_httpClient postDataWithPath:@"user/check-otp" andParam:params isShowfailureAlert:YES withSuccessBlock:^(id success) {
        [CommonFunction hideLoadingView];
        if ([success isKindOfClass:NSDictionary.class]) {
            if([success codeForKey:@"error_code"] == 0) {
                if ([self.delegate respondsToSelector:@selector(checkOTPSuccess:)]) {
                    [self.delegate checkOTPSuccess:YES];
                }
            } else {
                [CommonFunction showToast:[success stringForKey:@"message"]];
            }
        } else {
            [CommonFunction showToast:@"Không có dữ liệu"];
        }
    } withFailBlock:^(id fail) {
        [CommonFunction hideLoadingView];
        [CommonFunction showToast:@"Không có dữ liệu"];
    }];
}

- (IBAction)didSelectBtnResendOTP:(id)sender {
    NSDictionary *params = @{@"type": _type,
                             @"email": _email ?: @""
                             };
    [CommonFunction showLoadingView];
    [_httpClient postDataWithPath:@"user/resend-otp" andParam:params isShowfailureAlert:YES withSuccessBlock:^(id success) {
        [CommonFunction hideLoadingView];
        if ([success isKindOfClass:NSDictionary.class]) {
            if([success codeForKey:@"error_code"] == 0) {
                self.lbTitle.attributedText = self->_attributedString;
            } else {
                self.lbTitle.attributedText = [self getAttributedErrorWithString:[success stringForKey:@"errorCode"]];
            }
        } else {
            self.lbTitle.attributedText = [self getAttributedErrorWithString:@"Có lỗi xẩy ra vui lòng thử sau!"];
        }
    } withFailBlock:^(id fail) {
        [CommonFunction hideLoadingView];
        self.lbTitle.attributedText = [self getAttributedErrorWithString:@"Có lỗi xẩy ra vui lòng thử lại!"];
    }];
}

- (NSAttributedString *)getAttributedErrorWithString:(NSString *) text {
    NSAttributedString *errorAttributedText = [[NSAttributedString alloc] initWithString:text attributes:@{NSForegroundColorAttributeName : klineColorError}];
    return errorAttributedText;
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

@end
