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

- (void)binData:(FzVourcherInfoObject *) model {
    PageObject *page;
    if (model.acceptedPage.count > 0) {
        page = model.acceptedPage.firstObject;
    } else {
        page = [[PageObject alloc] initWithDataDictionary:@{}];
    }
    self.lblLocation.text = page.address?:@"";
    self.lblPhone.text = page.hotline?:@"";
    self.lblMoney.text = page.range_price?:@"";
    self.lblDesc.attributedText = [CommonFunction convertHTMLString:model.intro?:@""];
}

- (void)binDataWithPageInfo:(PageInfo *)model {
    self.lblLocation.text = model.page_view.address?:@"";
    self.lblPhone.text = model.page_view.hotline?:@"";
    self.lblMoney.text = model.page_view.range_price?:@"";
    self.lblDesc.attributedText = [CommonFunction convertHTMLString:model.descriptionPageInfo?:@""];
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
