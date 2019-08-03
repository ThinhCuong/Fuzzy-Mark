//
//  MVPromotionIntroCell.m
//  FuzzyMark
//
//  Created by Tu Tran on 6/19/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import "FMPromotionIntroCell.h"


@interface FMPromotionIntroCell ()

@property (weak, nonatomic) IBOutlet UILabel *lblLocation;
@property (weak, nonatomic) IBOutlet UILabel *lblPhone;
@property (weak, nonatomic) IBOutlet UILabel *lblMoney;
@property (weak, nonatomic) IBOutlet UILabel *lblDesc;

@end

@implementation FMPromotionIntroCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)binData:(PageObject *) model {
    self.lblLocation.text = model.address;
    self.lblPhone.text = model.hotline;
    self.lblMoney.text = model.range_price;
//     self.lblMoney.text = [NSString stringWithFormat:@"Mức giá: %@đ - %@đ", [self makeStringFormatMoneyString:model.min_price], [self makeStringFormatMoneyString:model.max_price]];
}

- (NSString *)makeStringFormatMoneyString:(NSInteger) totalAmount {
    NSNumberFormatter *formatter = [NSNumberFormatter new];
    [formatter setFormatterBehavior:NSNumberFormatterBehavior10_4];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [formatter setGroupingSeparator:@"."];
    [formatter setDecimalSeparator:@","];
    [formatter setMaximumFractionDigits:0];
    [formatter setMinimumFractionDigits:0];
    NSString *result = [formatter stringFromNumber:[NSNumber numberWithInteger:totalAmount]];
    return result;
}

@end
