//
//  HistoryBillHeaderCell.m
//  FuzzyMark
//
//  Created by Tu Tran on 5/6/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import "FMHeaderViewCell.h"
@interface FMHeaderViewCell ()
// HistoryBillHeaderCell
@property (weak, nonatomic) IBOutlet UILabel *lblCode;

// RegisterPromotionHeaderCell
@property (weak, nonatomic) IBOutlet UILabel *lblTime;

@end

@implementation FMHeaderViewCell
- (IBAction)didSelectBtnDetail:(id)sender {
    
}

- (void)binDataHistoryBill:(NSString *) code {
    if(!self.lblCode) {
        return;
    }
    self.lblCode.text = code ?:@"";
}

- (void)binDataRegisterPromotion:(NSString *) time {
    if(!self.lblTime) {
        return;
    }
    self.lblTime.text = time ?:@"";
}


@end
