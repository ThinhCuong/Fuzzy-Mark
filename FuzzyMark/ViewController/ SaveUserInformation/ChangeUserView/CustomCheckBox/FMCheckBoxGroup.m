//
//  FMCheckBoxGroup.m
//  FuzzyMark
//
//  Created by Tu Tran on 7/10/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import "FMCheckBoxGroup.h"
#import "TNCheckBox+SingleSelect.h"

@implementation FMCheckBoxGroup

- (void)checkBoxDidChange:(TNCheckBox *)checkbox {
    TNCheckBox *oldCheckbox;
    for (TNCheckBox *itemCheckbox in self.radioButtons) {
        if(![itemCheckbox isEqual:checkbox]) {
            oldCheckbox = itemCheckbox;
            oldCheckbox.data.checked = NO;
            [oldCheckbox checkWithAnimation:YES];
        }
    }
    [super checkBoxDidChange:checkbox];
}

@end
