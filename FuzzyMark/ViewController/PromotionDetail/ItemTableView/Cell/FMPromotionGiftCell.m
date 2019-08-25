//
//  FMPromotionGift.m
//  FuzzyMark
//
//  Created by Tu Tran on 6/19/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import "FMPromotionGiftCell.h"

@interface FMPromotionGiftCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imgBanner;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblAddress;
@property (weak, nonatomic) IBOutlet UILabel *lblSale;

@end

@implementation FMPromotionGiftCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)binData:(RewardObject *) model {
    [self.imgBanner sd_setImageWithURL:[NSURL URLWithString:model.image]];
    self.lblAddress.text = model.page.address;
    self.lblSale.text = [NSString stringWithFormat:@"Hoàn tiền %@%ld", @"%", model.page.discount];
}

@end
