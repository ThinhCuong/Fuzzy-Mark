//
//  FMInputPhoneNumberVC.m
//  FuzzyMark
//
//  Created by Tu Tran on 7/28/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import "FMInputEmailVC.h"
#import "FuzzyMark-Swift.h"
#import "UserInformation.h"

@interface FMInputEmailVC () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *tfEmail;
@property (weak, nonatomic) IBOutlet UIButton *btnSuccess;
@end

@implementation FMInputEmailVC

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [_tfEmail addTarget:self action:@selector(textFieldEditingChange:) forControlEvents:UIControlEventEditingChanged];
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

- (BOOL)validateEmailWithString:(NSString *) email {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

- (void)textFieldEditingChange:(UITextField *) textField {
    TJTextField *lineTextField = (TJTextField *) textField;
    if ([self validateEmailWithString:textField.text]) {
        _btnSuccess.enabled = YES;
        lineTextField.lineColor = klineColorSuccess;
    } else {
        _btnSuccess.enabled = NO;
        lineTextField.lineColor = klineColorError;
    }
}

#pragma mark - IBAction
- (IBAction)didSelectBtnSuccess:(id)sender {
    if ([self.delegate respondsToSelector:@selector(outputEmailSuccess:)]) {
        [self.delegate outputEmailSuccess:_tfEmail.text];
    }
}


@end
