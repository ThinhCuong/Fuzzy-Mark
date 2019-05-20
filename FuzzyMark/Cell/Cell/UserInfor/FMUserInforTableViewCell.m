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
