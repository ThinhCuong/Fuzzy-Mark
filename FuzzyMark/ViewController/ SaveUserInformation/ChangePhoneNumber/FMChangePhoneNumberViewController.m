//
//  FMChangePhoneNumberViewController.m
//  FuzzyMark
//
//  Created by Tu Tran on 5/19/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import "FMChangePhoneNumberViewController.h"
#import "FuzzyMark-Swift.h"

@interface FMChangePhoneNumberViewController ()
@property (weak, nonatomic) IBOutlet TJTextField *tfOldNumberPhone;
@property (weak, nonatomic) IBOutlet TJTextField *tfNewNumberPhone;
@property (weak, nonatomic) IBOutlet UIButton *btnSave;
@end

@implementation FMChangePhoneNumberViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navTitle = @"Thay đổi số điện thoại";
    [_tfNewNumberPhone addTarget:self action:@selector(textfieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [_tfOldNumberPhone addTarget:self action:@selector(textfieldDidChange:) forControlEvents:UIControlEventEditingChanged];
}

- (BOOL)validatePhoneWithString:(NSString *) phoneNumber {
    NSString *phoneRegex = @"^((\\+)|(00))[0-9]{6,14}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    return [phoneTest evaluateWithObject:phoneNumber];
}
- (BOOL)enableButtonSuccess {
    BOOL isValidaOldPhone = [self validatePhoneWithString:_tfOldNumberPhone.text];
    BOOL isValidaNewPhone = [self validatePhoneWithString:_tfNewNumberPhone.text];
    return (isValidaOldPhone && isValidaNewPhone);
}

- (void)changeStateTextField:(UITextField *) sender {
    if (![sender isKindOfClass:TJTextField.class]) {
        return;
    }
    TJTextField *textField = (TJTextField *) sender;
    BOOL isValidateTF;
    isValidateTF = [self validatePhoneWithString:textField.text];
    textField.lineColor = isValidateTF ? klineColorSuccess : klineColorError;
}

- (void)textfieldDidChange:(UITextField *) sender {
    [self changeStateTextField:sender];
    _btnSave.enabled = [self enableButtonSuccess];
}

@end
