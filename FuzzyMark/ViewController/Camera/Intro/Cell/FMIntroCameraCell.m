//
//  FMIntroCameraCell.m
//  FuzzyMark
//
//  Created by Tu Tran on 5/29/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import "FMIntroCameraCell.h"

@interface FMIntroCameraCell ()
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UIImageView *imgBill;
@end

@implementation FMIntroCameraCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)billDataWithImage:(NSString *) img andTitle: (NSString *) title {
    self.lblTitle.text = title;
    self.imgBill.image = [UIImage imageNamed:img];
}

@end
