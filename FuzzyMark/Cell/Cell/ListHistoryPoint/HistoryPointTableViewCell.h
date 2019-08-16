//
//  HistoryPointTableViewCell.h
//  FuzzyMark
//
//  Created by Tu Tran on 5/16/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HistoryCaptureObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface HistoryPointTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lbTitle;
@property (weak, nonatomic) IBOutlet UILabel *lbTime;
@property (weak, nonatomic) IBOutlet UILabel *lbPoint;
- (void)binData:(HistoryCaptureObject *) obj;
@end

NS_ASSUME_NONNULL_END
