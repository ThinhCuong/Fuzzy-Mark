//
//  RegisterPromotionCell.m
//  FuzzyMark
//
//  Created by Tu Tran on 5/20/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import "RegisterPromotionCell.h"

@interface RegisterPromotionCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imgIcon;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblLocation;
@property (weak, nonatomic) IBOutlet UILabel *lblSale;
@property (weak, nonatomic) IBOutlet UILabel *lblTime;


@end

@implementation RegisterPromotionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)binDataWithVoucher:(Voucher *) model {
    self.lblName.text = model.name ?: @"";
    self.lblLocation.text = model.page.address ?: @"";
    self.lblSale.text = [NSString stringWithFormat:@"Hoàn tiền %ld%@", (long)model.percent_discount,@"%"];
    self.lblTime.text = model.time_bookmark ?: @"";
    [self.imgIcon sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:kLogoPlaceholderImage];
}

@end
