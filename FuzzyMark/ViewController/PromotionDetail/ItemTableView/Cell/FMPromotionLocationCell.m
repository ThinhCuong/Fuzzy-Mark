//
//  MVPromotionLocationCell.m
//  FuzzyMark
//
//  Created by Tu Tran on 6/19/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import "FMPromotionLocationCell.h"

@interface FMPromotionLocationCell ()

@property (weak, nonatomic) IBOutlet UILabel *lblLocation;
@property (weak, nonatomic) IBOutlet UILabel *lblPhone;

@end

@implementation FMPromotionLocationCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)binData:(PageObject *) model {
    self.lblLocation.text = model.address;
    self.lblPhone.text = model.hotline;
}

- (IBAction)didSelectGoto:(id)sender {
    
}

@end
