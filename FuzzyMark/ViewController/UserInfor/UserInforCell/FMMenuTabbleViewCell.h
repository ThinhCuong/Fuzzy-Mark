//
//  FMMenuTabbleViewCell.h
//  FuzzyMark
//
//  Created by Tu Tran on 4/14/19.
//  Copyright © 2019 Tu Tran. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FMCellBlockObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface FMMenuTabbleViewCell : UITableViewCell
@property (assign, nonatomic, getter=isHideBotomLine) BOOL hideBotomLine;
@property (assign, nonatomic, getter=isTypeBlock) FMTableViewCellBlock typeBlock;
- (void)binDataWith:(FMCellBlockObject *) model;
@end

NS_ASSUME_NONNULL_END
