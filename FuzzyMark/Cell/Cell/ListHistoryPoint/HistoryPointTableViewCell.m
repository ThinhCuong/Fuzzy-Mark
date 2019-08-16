//
//  HistoryPointTableViewCell.m
//  FuzzyMark
//
//  Created by Tu Tran on 5/16/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import "HistoryPointTableViewCell.h"

@implementation HistoryPointTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)binData:(HistoryCaptureObject *) obj {
    self.lbTitle.text = obj.title ?: @"";
    self.lbTime.text = obj.time ?: @"";
    self.lbPoint.text = [NSString stringWithFormat:@"+%ld", (long)obj.point];
}

@end
