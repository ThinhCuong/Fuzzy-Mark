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
@property (weak, nonatomic) IBOutlet UILabel *lbTitle;

@end

@implementation FMOTPViewController {
    NSAttributedString *_attributedString;
}

#pragma mark - life cycle
- (instancetype)initWithTitleAttributedString:(NSAttributedString *) attributedString {
    self = [super init];
    if (self) {
        _attributedString = attributedString;
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
}

#pragma mark - private
- (void)textFieldDidChange:(UITextField *) sender {
    if (![sender isKindOfClass:TJTextField.class]) {
        return;
    }
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
