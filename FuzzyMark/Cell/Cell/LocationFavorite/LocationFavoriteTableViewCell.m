//
//  LocationFavoriteTableViewCell.m
//  FuzzyMark
//
//  Created by Tu Tran on 5/17/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import "LocationFavoriteTableViewCell.h"

@interface LocationFavoriteTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imgLogo;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblMoney;
@property (weak, nonatomic) IBOutlet UILabel *lblDistance;
@property (weak, nonatomic) IBOutlet UILabel *lblLocation;
@property (weak, nonatomic) IBOutlet UILabel *lblNumberRate;
@property (weak, nonatomic) IBOutlet UILabel *lblNumberComment;
@property (weak, nonatomic) IBOutlet UIButton *btnDetail;


@end

@implementation LocationFavoriteTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.imgLogo.layer.cornerRadius = self.btnDetail.frame.size.height / 2;
    self.imgLogo.clipsToBounds = YES;
    self.btnDetail.layer.cornerRadius = 3;
    self.btnDetail.layer.borderWidth = 1;
    self.btnDetail.layer.borderColor = [UIColor colorWithRed:0.2 green:0.6 blue:0.86 alpha:1.0].CGColor;
}

@end
