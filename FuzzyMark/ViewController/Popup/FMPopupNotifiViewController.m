//
//  FMPopupNotifiViewController.m
//  FuzzyMark
//
//  Created by Tu Tran on 8/18/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import "FMPopupNotifiViewController.h"
#import "FMLoginAccountViewController.h"

@interface FMPopupNotifiViewController ()

@end

@implementation FMPopupNotifiViewController {
    NSString *_title;
}

- (instancetype)initWithTitle:(NSString *) title
{
    self = [super init];
    if (self) {
        _title = title;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.lbTitle.text = _title ?: @"";
}

- (IBAction)didSlectAccept:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        if ([self.delegate respondsToSelector:@selector(didSelectChooseSuccessBlock)]) {
            [self.delegate didSelectChooseSuccessPopup];
        }
        self.didSelectChooseSuccessBlock ? self.didSelectChooseSuccessBlock() : 0;
    }];
}

- (IBAction)didSlectCancle:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        if ([self.delegate respondsToSelector:@selector(didSelectChooseCanCleBlock)]) {
            [self.delegate didSelectChooseCanclePopup];
        };
        self.didSelectChooseCanCleBlock ? self.didSelectChooseCanCleBlock() : 0;
    }];
}

@end
