//
//  HistoryPointHeaderTableViewCell.h
//  FuzzyMark
//
//  Created by Tu Tran on 5/16/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HistoryPointHeaderTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *lbPoint;
- (void)binDataWithPoint:(NSInteger) point;
@end

NS_ASSUME_NONNULL_END
