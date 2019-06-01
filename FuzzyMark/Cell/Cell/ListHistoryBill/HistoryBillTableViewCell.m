//
//  HistoryBillTableViewCell.m
//  FuzzyMark
//
//  Created by Tu Tran on 5/6/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import "HistoryBillTableViewCell.h"

@interface HistoryBillTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imgBanner;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblLocation;
@property (weak, nonatomic) IBOutlet UILabel *lblMoney;

@end

@implementation HistoryBillTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.imgBanner.layer.cornerRadius = self.imgBanner.frame.size.height/2;
    self.imgBanner.clipsToBounds = YES;
}

- (void)binData:(HistoryBill *) model {
    [self.imgBanner sd_setImageWithURL:[NSURL URLWithString:model.voucher.image] placeholderImage:nil];
    self.lblName.text = model.voucher.page.name ?: @"";
    self.lblLocation.text = model.voucher.page.address ?:@"";
    self.lblMoney.text = [NSString stringWithFormat:@"Hoàn tiền %@%ld", @"%", (long)model.voucher.percent_discount];
}

@end
