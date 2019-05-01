//
//  FMMenuTabbleViewCell.m
//  FuzzyMark
//
//  Created by Tu Tran on 4/14/19.
//  Copyright © 2019 Tu Tran. All rights reserved.
//

#import "FMMenuTabbleViewCell.h"

@interface FMMenuTabbleViewCell ()
@property (weak, nonatomic) IBOutlet UIView *bottomLineView;
@property (weak, nonatomic) IBOutlet UIImageView *imgIcon;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;

@end
@implementation FMMenuTabbleViewCell

- (void)setHideBotomLine:(BOOL)hideBotomLine {
    _hideBotomLine = hideBotomLine;
    self.bottomLineView.hidden = hideBotomLine;
}

- (void)binDataWith:(FMCellBlockObject *) model {
    self.imgIcon.image = model.image;
    self.lblTitle.text = model.title;
    self.typeBlock = model.typeBlock;
}

@end
