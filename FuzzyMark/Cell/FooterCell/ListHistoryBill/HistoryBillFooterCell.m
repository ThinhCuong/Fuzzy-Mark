//
//  HistoryBillFooterCell.m
//  FuzzyMark
//
//  Created by Tu Tran on 5/6/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import "HistoryBillFooterCell.h"

@interface HistoryBillFooterCell ()

@property (weak, nonatomic) IBOutlet UILabel *lblDate;
@property (weak, nonatomic) IBOutlet UILabel *lblNoti;

@end

@implementation HistoryBillFooterCell

- (void)binData:(HistoryBill *)model {
    self.lblDate.text = model.time?:@"";
    self.lblNoti.text = model.reason?:@"";
}

@end
