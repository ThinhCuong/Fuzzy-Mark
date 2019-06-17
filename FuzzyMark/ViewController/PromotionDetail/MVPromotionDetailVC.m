//
//  MVPromotionDetailVC.m
//  FuzzyMark
//
//  Created by Tu Tran on 6/16/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import "MVPromotionDetailVC.h"

@interface MVPromotionDetailVC ()
@property (weak, nonatomic) IBOutlet UIImageView *imgBanner;
@property (weak, nonatomic) IBOutlet UIView *imgVoucher;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblTime;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UIButton *btnSale;
@property (weak, nonatomic) IBOutlet UILabel *lblSale;
@property (weak, nonatomic) IBOutlet UILabel *lblDesc;

@end

@implementation MVPromotionDetailVC {
    NSString *_idVoucher;
}

- (instancetype)initWithIDVoucher:(NSString *) idVoucher
{
    self = [super init];
    if (self) {
        _idVoucher = idVoucher;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

@end
