//
//  FMIntroChangePhoneNumber.m
//  FuzzyMark
//
//  Created by Tu Tran on 5/19/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import "FMIntroChangePhoneNumber.h"
#import "FMChangePhoneNumberViewController.h"

@interface FMIntroChangePhoneNumber ()

@end

@implementation FMIntroChangePhoneNumber

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navTitle = @"Thay đổi số điện thoại";
}

- (IBAction)didSelectBtnNext:(id)sender {
    FMChangePhoneNumberViewController *vc = [[FMChangePhoneNumberViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}


@end
