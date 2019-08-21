//
//  FMSendImageVoucherSuccessVC.m
//  FuzzyMark
//
//  Created by Tu Tran on 8/22/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import "FMSendImageVoucherSuccessVC.h"
#import "AppDelegate.h"

@interface FMSendImageVoucherSuccessVC ()

@end

@implementation FMSendImageVoucherSuccessVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)didSelectBtnClose:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)didSelectBtnHome:(id)sender {
    [appDelegate selectTabWithIndex:0];
}

- (IBAction)didSelectBtnNewImage:(id)sender {
    [appDelegate selectTabWithIndex:2];
}

@end
