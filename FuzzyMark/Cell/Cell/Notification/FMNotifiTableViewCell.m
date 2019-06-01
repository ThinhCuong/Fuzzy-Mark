//
//  FMNotifiTableViewCell.m
//  FuzzyMark
//
//  Created by Tu Tran on 4/14/19.
//  Copyright © 2019 Tu Tran. All rights reserved.
//

#import "FMNotifiTableViewCell.h"
#import "Notifi.h"

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
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)binData:(Notifi *) model {
    self.lblTitle.text = model.title ?: @"";
    self.lblContent.text = model.descriptions ?: @"";
    self.lblTime.text = model.time ?: @"";
    if(!model.is_read) {
        self.backgroundColor = [UIColor colorWithRed:237/255.0 green:248/255.0 blue:255/255.0 alpha:1.0];
    } else {
        self.backgroundColor = [UIColor whiteColor];
    }
    if(model.idNoti == 1) {
        self.imgIcon.image = [UIImage imageNamed:@"icon_no_image"];
    } else if (model.idNoti == 2) {
        self.imgIcon.image = [UIImage imageNamed:@"icon_no_image"];
    } else if (model.idNoti == 3) {
        self.imgIcon.image = [UIImage imageNamed:@"icon_no_image"];
    } else {
        self.imgIcon.image = [UIImage imageNamed:@"icon_no_image"];
    }
}

@end
