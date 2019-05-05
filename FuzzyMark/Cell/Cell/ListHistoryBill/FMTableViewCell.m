//
//  HistoryBillTableViewCell.m
//  FuzzyMark
//
//  Created by Tu Tran on 5/6/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import "FMTableViewCell.h"
@interface FMTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imgBanner;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblLocation;
@property (weak, nonatomic) IBOutlet UILabel *lblMoney;

@end

@implementation FMTableViewCell

- (void)binData:(RegisterPromotion *) model {
    
}

@end
