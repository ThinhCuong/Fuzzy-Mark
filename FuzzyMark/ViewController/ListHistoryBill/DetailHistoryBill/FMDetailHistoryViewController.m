//
//  FMDetailHistoryViewController.m
//  FuzzyMark
//
//  Created by Tu Tran on 5/19/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import "FMDetailHistoryViewController.h"

@interface FMDetailHistoryViewController ()
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblFullName;
@property (weak, nonatomic) IBOutlet UILabel *lblLocation;
@property (weak, nonatomic) IBOutlet UILabel *lblStatus;
@property (weak, nonatomic) IBOutlet UILabel *lblContent;
@property (weak, nonatomic) IBOutlet UILabel *lblCode;
@property (weak, nonatomic) IBOutlet UILabel *lblTimeGive;
@property (weak, nonatomic) IBOutlet UILabel *lblRequest;
@property (weak, nonatomic) IBOutlet UILabel *lblAccep;
@property (weak, nonatomic) IBOutlet UIImageView *imgBill;
@property (weak, nonatomic) IBOutlet UIButton *btnRequest;
@property (weak, nonatomic) IBOutlet UIButton *btnSupport;


@end

@implementation FMDetailHistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self binData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setNavigationBar];
}

- (void)setNavigationBar {
    self.navigationItem.title = @"Thông tin giao dịch";
    self.navigationController.navigationBar.topItem.title = @"";
    self.isHideNavigationBar = NO;
}

- (void)setupUI {
    
}

- (void)binData {
//    self.lblName.text = self.model.voucher.name ?: @"";
//    self.lblFullName.text = self.model.voucher.page.name ?:@"";
//    self.lblLocation.text = self.model.voucher.page.address ?:@"";
//    if(self.model.status == 0) {
//        self.lblStatus.text = @"Từ chối";
//    } else if(self.model.status == 1) {
//        self.lblStatus.text = @"Từ chối";
//    } else {
//        self.lblStatus.text = @"Từ chối";
//    }
//    self.lblContent.text = self.model.voucher.descriptionVoucher ?:@"";
//    self.lblCode.text = self.model.transaction_id;
//    self.lblTimeGive.text = self.model.
}



@end
