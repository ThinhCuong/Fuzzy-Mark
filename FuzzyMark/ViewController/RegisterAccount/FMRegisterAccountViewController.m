//
//  FMRegisterAccountViewController.m
//  FuzzyMark
//
//  Created by Tu Tran on 7/21/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import "FMRegisterAccountViewController.h"
#import "FuzzyMark-Swift.h"
#import "FMOTPViewController.h"

@interface FMRegisterAccountViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet TJTextField *tfEmail;
@property (weak, nonatomic) IBOutlet TJTextField *tfFullName;
@property (weak, nonatomic) IBOutlet TJTextField *tfPassword;
@property (weak, nonatomic) IBOutlet TJTextField *tfRepassWord;
@property (weak, nonatomic) IBOutlet UIButton *btnSuccess;
@property (weak, nonatomic) IBOutlet UIButton *btnShowPass;
@property (strong, nonatomic) UITapGestureRecognizer *tapCloseKeyboard;
@end

@implementation FMRegisterAccountViewController {
    BaseCallApi *_httpClient;
    UserInformation *_userModel;
}

#pragma mark - life cycle
- (instancetype)initWithUser:(UserInformation *) userModel {
    self = [super init];
    if (self) {
        _userModel = userModel;
        if (!_userModel) {
            _userModel = [[UserInformation alloc] init];
        }
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.tfEmail addTarget:self action:@selector(textfieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.tfFullName addTarget:self action:@selector(textfieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.tfPassword addTarget:self action:@selector(textfieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.tfRepassWord addTarget:self action:@selector(textfieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidHide:)
                                                 name:UIKeyboardDidHideNotification
                                               object:nil];
    _tapCloseKeyboard = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeKeyboart)];
    _httpClient = [BaseCallApi defaultInitWithBaseURL];
    _tfEmail.text = _userModel.email ?: @"";
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setNavigationBar];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.clipsToBounds = NO;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter ] removeObserver:self];
}

#pragma mark - private
- (void)setNavigationBar {
    self.navigationItem.title = @"";
    self.navigationController.navigationBar.topItem.title = @"";
    self.isHideNavigationBar = NO;
    self.navigationController.navigationBar.clipsToBounds = YES;
}

- (BOOL)validateNameWithString:(NSString *) name {
    return name.length > 0;
}

- (BOOL)validateEmailWithString:(NSString *) email {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

- (BOOL)validatePasswordWithString:(NSString *) password {
    NSString *passwordRegex = @"^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[$@$!%*?&])[A-Za-z\\d$@$!%*?&]{10,}";
    NSPredicate *passwordTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", passwordRegex];
    return [passwordTest evaluateWithObject:password];
}

- (BOOL)validateRepasswordWithString:(NSString *) repassword  {
    return [repassword isEqualToString:self.tfPassword.text];
}

- (BOOL)enableButtonSuccess {
    BOOL isValidaName = [self validateNameWithString:_tfFullName.text];
    BOOL isValidaEmail = [self validateEmailWithString:_tfEmail.text];
    BOOL isValidaPassword = [self validatePasswordWithString:_tfPassword.text];
    BOOL isValidaRepassword = [self validateRepasswordWithString:_tfRepassWord.text];
    return (isValidaName && isValidaEmail && isValidaPassword && isValidaRepassword);
}

- (void)changeStateTextField:(UITextField *) sender {
    if (![sender isKindOfClass:TJTextField.class]) {
        return;
    }
    TJTextField *textField = (TJTextField *) sender;
    BOOL isValidateTF;
    if([textField isEqual:_tfFullName]) {
        isValidateTF = [self validateNameWithString:textField.text];
    } else if ([textField isEqual:_tfEmail]) {
        isValidateTF = [self validateEmailWithString:textField.text];
    } else if ([textField isEqual:_tfPassword]) {
        isValidateTF = [self validatePasswordWithString:textField.text];
    } else {
        isValidateTF = [self validateRepasswordWithString:textField.text];
    }
    textField.lineColor = isValidateTF ? klineColorSuccess : klineColorError;
}

- (void)closeKeyboart {
    [self.view endEditing:YES];
}

- (void)keyboardDidShow: (NSNotification *) notif{
    [self.view addGestureRecognizer:_tapCloseKeyboard];
}

- (void)keyboardDidHide: (NSNotification *) notif{
    [self.view removeGestureRecognizer:_tapCloseKeyboard];
}

#pragma mark - IBAction
- (IBAction)didSelectButtonSuccess:(id)sender {
    _userModel.email = _tfEmail.text;
    _userModel.user_view.name = _tfFullName.text;
    
    NSDictionary *params = @{@"email": _tfEmail.text,
                             @"full_name": _tfFullName.text,
                             @"password": _tfPassword.text
                             };
    [CommonFunction showLoadingView];
    [_httpClient postDataWithPath:@"user/register" andParam:params isShowfailureAlert:YES withSuccessBlock:^(id success) {
        [CommonFunction hideLoadingView];
        if ([success isKindOfClass:NSDictionary.class]) {
            if ([success codeForKey:@"error_code"] == 0) {
                [self saveDataRegisterSuccess];
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

- (IBAction)didSelectShowPassword:(id)sender {
    if(_tfPassword.isSecureTextEntry) {
        _tfPassword.secureTextEntry = NO;
        [_btnShowPass setTitle:@"ẨN" forState:UIControlStateNormal];
    } else {
        _tfPassword.secureTextEntry = YES;
        [_btnShowPass setTitle:@" " forState:UIControlStateNormal];
    }
}

- (void)textfieldDidChange:(UITextField *) sender {
    [self changeStateTextField:sender];
     _btnSuccess.enabled = [self enableButtonSuccess];
}

- (void)saveDataRegisterSuccess {
    NSDictionary *params = @{};
    [_httpClient getDataWithPath:@"/user/profile" andParam:params isShowfailureAlert:YES withSuccessBlock:^(id success) {
        [CommonFunction hideLoadingView];
        if ([success isKindOfClass:NSDictionary.class]) {
            if ([success codeForKey:@"error_code"] == 0) {
                NSDictionary *dict = [success dictionaryForKey:@"data"];
                UserInformation *user = [[UserInformation alloc] initWithDict:dict];
                [UserInfo setUserInforWithUserModel:user];
                self.registerSuccess ? self.registerSuccess() : 0;
            } else {
                [CommonFunction showToast:[success stringForKey:@"message"]];
            }
        } else {
            [CommonFunction showToast:kMessageError];
        }
    } withFailBlock:^(id fail) {
        [CommonFunction showToast:kMessageError];
    }];
}

@end
