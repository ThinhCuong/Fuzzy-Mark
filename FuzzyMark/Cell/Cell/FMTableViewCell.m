//
//  HistoryBillTableViewCell.m
//  FuzzyMark
//
//  Created by Tu Tran on 5/6/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import "FMTableViewCell.h"
@interface FMTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imgBanner;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblLocation;
@property (weak, nonatomic) IBOutlet UILabel *lblMoney;

@end

@implementation FMTableViewCell

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.imgBanner.layer.cornerRadius = self.imgBanner.frame.size.height/2;
        self.imgBanner.clipsToBounds = YES;
    }
    return self;
}

- (void)binData:(HistoryBill *) model {
    [self.imgBanner sd_setImageWithURL:[NSURL URLWithString:model.voucher.image] placeholderImage:nil];
    self.lblName.text = model.voucher.name ?:@"";
    self.lblLocation.text = model.voucher.page.address ?:@"";
    self.lblMoney.text = model.voucher.descriptions;
    
}

@end
