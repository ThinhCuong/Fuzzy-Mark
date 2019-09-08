//
//  FMUserInforTableViewCell.m
//  FuzzyMark
//
//  Created by Tu Tran on 4/14/19.
//  Copyright © 2019 Tu Tran. All rights reserved.
//

#import "FMUserInforTableViewCell.h"

@interface FMUserInforTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imgUser;
@property (weak, nonatomic) IBOutlet UIButton *btnAddImageUser;
@property (weak, nonatomic) IBOutlet UILabel *lblUserName;
@property (weak, nonatomic) IBOutlet UILabel *lblPhone;
@property (weak, nonatomic) IBOutlet UILabel *lblEmail;
@property (weak, nonatomic) IBOutlet UILabel *lblNumberBill;
@property (weak, nonatomic) IBOutlet UILabel *lblPoint;
@end

@implementation FMUserInforTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _imgUser.layer.cornerRadius = _imgUser.frame.size.height/2;
    _imgUser.clipsToBounds = YES;
}

- (void)binDataLoginWithUserInfor:(UserInformation *) userInfo {
    [[SDImageCache sharedImageCache] clearMemory];
    [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
       [self.imgUser sd_setImageWithURL:[NSURL URLWithString:userInfo.user_view.avatar] placeholderImage:kUserPlaceholderImage];
    }];
    
    self.lblUserName.text = userInfo.user_view.name ?: @"---";
    
    if (userInfo.phone.length > 0) {
        self.lblPhone.text = userInfo.phone;
        self.lblPhone.textColor = klineColorNormal;
    } else {
        self.lblPhone.text = @"Chưa cập nhật";
        self.lblPhone.textColor = klineColorError;
    }
    
    if (userInfo.email.length > 0) {
        self.lblEmail.text = userInfo.email;
        self.lblEmail.textColor = klineColorNormal;
    } else {
        self.lblEmail.text = @"Chưa cập nhật";
        self.lblEmail.textColor = klineColorError;
    }
    
    self.lblNumberBill.text = [@(userInfo.history_count) stringValue];
    self.lblPoint.text = [@(userInfo.point_reward) stringValue];
}

- (void)binDataNotLogin {
    self.imgUser.image = [UIImage imageNamed:@"ic_user"];
    
    self.lblUserName.text = @"---";
    
    self.lblPhone.text = @"Chưa cập nhật";
    self.lblPhone.textColor = klineColorError;
    
    self.lblEmail.text = @"Chưa cập nhật";
    self.lblEmail.textColor = klineColorError;
    
    self.lblNumberBill.text = 0;
    self.lblPoint.text = 0;
}

- (IBAction)didSelectButtonAddImageUser:(id)sender {
    if([self.delegate respondsToSelector:@selector(didSelectButtonAddImageUser)]) {
        [self.delegate didSelectButtonAddImageUser];
    }
}

- (IBAction)didSelectButtonHistory:(id)sender {
    if([self.delegate respondsToSelector:@selector(didSelectButtonHistory)]) {
        [self.delegate didSelectButtonHistory];
    }
}

- (IBAction)didSelectButtonPoint:(id)sender {
    if([self.delegate respondsToSelector:@selector(didSelectButtonPoint)]) {
        [self.delegate didSelectButtonPoint];
    }
}

@end
