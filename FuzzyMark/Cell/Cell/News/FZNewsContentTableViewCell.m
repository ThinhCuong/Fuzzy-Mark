//
//  FZNewsContentTableViewCell.m
//  FuzzyMark
//
//  Created by Nguyen Cuong on 8/26/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import "FZNewsContentTableViewCell.h"

@implementation FZNewsContentTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)bindData:(NSString *)content {
    self.contentLabel.attributedText = [CommonFunction convertHTMLString:content?:@""];
}
@end
