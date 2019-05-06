//
//  HistoryBillFooterCell.m
//  FuzzyMark
//
//  Created by Tu Tran on 5/6/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import "FMFooterViewCell.h"
@interface FMFooterViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *lblDate;
@property (weak, nonatomic) IBOutlet UILabel *lblNoti;

@end

@implementation FMFooterViewCell

- (void)binData:(NSString *) date andNoti: (NSString *) noti {
    self.lblDate.text = date?:@"";
    self.lblNoti.text = noti?:@"";
}

@end
