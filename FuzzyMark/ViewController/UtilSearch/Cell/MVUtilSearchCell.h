//
//  MVUtilSearchCell.h
//  FuzzyMark
//
//  Created by Tu Tran on 9/2/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FMCheckBoxGroup.h"
#import "ConfigAppObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface MVUtilSearchCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lbName;
@property (weak, nonatomic) IBOutlet UIImageView *imgCheckBox;
- (void)binDataWithService:(Service *) model;
- (void)selectedCheckBox:(BOOL) selected;
@end

NS_ASSUME_NONNULL_END
