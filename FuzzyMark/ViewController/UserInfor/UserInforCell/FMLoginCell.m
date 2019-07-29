//
//  FMLoginCell.m
//  FuzzyMark
//
//  Created by Tu Tran on 7/29/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import "FMLoginCell.h"

@implementation FMLoginCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (IBAction)didSelectButtonLogin:(id)sender {
    if([self.delegate respondsToSelector:@selector(didSelectLogin)]) {
        [self.delegate didSelectLogin];
    }
}

@end
