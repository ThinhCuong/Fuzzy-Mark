//
//  FMMenuHomeCategoryCell.m
//  FuzzyMark
//
//  Created by Tu Tran on 9/4/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import "FMMenuHomeCategoryCell.h"

@implementation FMMenuHomeCategoryCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)binDataWithIconGroup:(IConObject *) obj {
    [self.imvCategory sd_setImageWithURL:obj.image];
    self.lbCategory.text = obj.title?:@"";
}

@end
