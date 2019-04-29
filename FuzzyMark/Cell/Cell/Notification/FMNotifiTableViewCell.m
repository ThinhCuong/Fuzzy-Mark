//
//  FMNotifiTableViewCell.m
//  FuzzyMark
//
//  Created by Tu Tran on 4/14/19.
//  Copyright © 2019 Tu Tran. All rights reserved.
//

#import "FMNotifiTableViewCell.h"
@interface FMNotifiTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblContent;
@property (weak, nonatomic) IBOutlet UILabel *lblTime;
@property (weak, nonatomic) IBOutlet UIImageView *imgIcon;
@end
@implementation FMNotifiTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.imgIcon.layer.cornerRadius = 10;
    self.imgIcon.clipsToBounds = YES;
    
    self.selectedBackgroundView = [[UIView alloc] init];
    self.selectedBackgroundView.backgroundColor = [UIColor colorWithRed:238/255.0 green:248/255.0 blue:254/255.0 alpha:1.0];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)binData:(id) model {
    self.lblTitle.text = @"Hoàn tiền 15% cho hóa đơn Hải sản 4 mùa";
    self.lblContent.text = @"Số tiền hoàn lại: 15.000đ đã được cộng vào ví tài khoản. Cảm ơn quý khách đã sử dụng dịch vụ của Clingcling";
    self.lblTime.text = @"12:00, 20/12/2019";
    self.imgIcon.image =  [UIImage imageNamed:@"ic_home"];
}

@end
