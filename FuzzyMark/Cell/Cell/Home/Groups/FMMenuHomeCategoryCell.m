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
    if (![obj.image isEqualToString:@"icon_home_news"] && ![obj.image isEqualToString:@"icon_home_map"]) {
        [self.imvCategory sd_setImageWithURL:[NSURL URLWithString:obj.image]];
    } else {
        self.imvCategory.image = [UIImage imageNamed:obj.image];
    }
    self.lbCategory.text = obj.title?:@"";
}

@end
