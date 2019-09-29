//
//  FMPageInfoAllRateCell.m
//  FuzzyMark
//
//  Created by Tu Tran on 9/23/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import "FMPageInfoAllRateCell.h"

@implementation FMPageInfoAllRateCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (IBAction)didSelectShowAllRate:(id)sender {
    if ([self.delegate respondsToSelector:@selector(didSelectShowAllRate)]) {
        [self.delegate didSelectShowAllRate];
    }
}


@end
