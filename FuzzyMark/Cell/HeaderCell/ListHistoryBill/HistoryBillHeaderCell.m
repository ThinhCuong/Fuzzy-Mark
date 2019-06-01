//
//  HistoryBillHeaderCell.m
//  FuzzyMark
//
//  Created by Tu Tran on 5/19/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import "HistoryBillHeaderCell.h"

@interface HistoryBillHeaderCell ()
@property (weak, nonatomic) IBOutlet UILabel *lblCode;

@end

@implementation HistoryBillHeaderCell

- (void)binData:(HistoryBill *) model {
    self.lblCode.text = model.transaction_id;
}

- (IBAction)didSlectDetail:(id)sender {
    
}


@end
