//
//  TNCheckBox+SingleSelect.m
//  FuzzyMark
//
//  Created by Tu Tran on 7/10/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import "TNCheckBox+SingleSelect.h"

@implementation TNCheckBox (SingleSelect)

- (void)buttonTapped:(id)sender {
    
    if(self.data.checked == YES) {
        return;
    }
    
    self.data.checked = !self.data.checked;
    [self checkWithAnimation:YES];
    
    if ([self.delegate respondsToSelector:@selector(checkBoxDidChange:)]) {
        [self.delegate checkBoxDidChange:self];
    }
}

@end
