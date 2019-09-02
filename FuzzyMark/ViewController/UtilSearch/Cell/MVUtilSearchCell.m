//
//  MVUtilSearchCell.m
//  FuzzyMark
//
//  Created by Tu Tran on 9/2/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import "MVUtilSearchCell.h"

@implementation MVUtilSearchCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)binDataWithService:(Service *) model {
    self.lbName.text = model.name;
    self.imgCheckBox.image = [UIImage imageNamed:@"ic-uncheckbox"];
}

- (void)selectedCheckBox:(BOOL) selected {
    if (selected) {
        self.imgCheckBox.image = [UIImage imageNamed:@"ic-checkbox"];
    } else {
        self.imgCheckBox.image = [UIImage imageNamed:@"ic-uncheckbox"];
    }
}


@end
