//
//  FZRewardTableViewCell.m
//  FuzzyMark
//
//  Created by Nguyen Cuong on 8/24/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import "FZRewardTableViewCell.h"
#import "CommonFunction.h"

@implementation FZRewardTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [CommonFunction setCornerRadiusUIImageView:self.image cornerRadiusValue:5];
    [self setBackgroundGradient:self.backGroundView color1Red:128 color1Green:216 color1Blue:255 color2Red:234 color2Green:128 color2Blue:252 alpha:0.9];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)bindData:(Promotion *)reward {
    [self.image sd_setImageWithURL: [NSURL URLWithString:reward.image]];
    self.discountLabel.text = [NSString stringWithFormat:@"Hoàn tiền %ld %s", (long)reward.percentDiscount, "%"];
}

- (void)setBackgroundGradient:(UIView *)mainView color1Red:(float)colorR1 color1Green:(float)colorG1 color1Blue:(float)colorB1 color2Red:(float)colorR2 color2Green:(float)colorG2 color2Blue:(float)colorB2 alpha:(float)alpha
{
    
    [mainView setBackgroundColor:[UIColor clearColor]];
    CAGradientLayer *grad = [CAGradientLayer layer];
    grad.frame = mainView.bounds;
    
    grad.colors = [NSArray arrayWithObjects:(id)[[UIColor colorWithRed:colorR1/255.0 green:colorG1/255.0 blue:colorB1/255.0 alpha:alpha] CGColor], (id)[[UIColor colorWithRed:colorR2/255.0 green:colorG2/255.0 blue:colorB2/255.0 alpha:alpha] CGColor], nil];
    
    [mainView.layer insertSublayer:grad atIndex:0];
}

@end
