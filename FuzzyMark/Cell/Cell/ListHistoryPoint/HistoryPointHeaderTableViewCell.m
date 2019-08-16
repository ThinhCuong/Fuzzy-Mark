//
//  HistoryPointHeaderTableViewCell.m
//  FuzzyMark
//
//  Created by Tu Tran on 5/16/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import "HistoryPointHeaderTableViewCell.h"

@implementation HistoryPointHeaderTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)binDataWithPoint:(NSInteger) point {
    self.lbPoint.text = [NSString stringWithFormat:@"%ld", (long)point];
}

@end
