//
//  RegisterPromotionsTableViewCell.m
//  FuzzyMark
//
//  Created by Tu Tran on 5/3/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import "RegisterPromotionsTableViewCell.h"

@interface RegisterPromotionsTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imgBanner;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblLocation;
@property (weak, nonatomic) IBOutlet UILabel *lblSale;
@property (weak, nonatomic) IBOutlet UILabel *lblTime;

@end

@implementation RegisterPromotionsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.imgBanner.layer.cornerRadius = self.imgBanner.frame.size.height / 2;
}



@end
