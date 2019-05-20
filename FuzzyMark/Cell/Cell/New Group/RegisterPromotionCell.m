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

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
