//
//  FMPageInfoAllRateCell.h
//  FuzzyMark
//
//  Created by Tu Tran on 9/23/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol FMPageInfoAllRateCellDelegate <NSObject>

- (void)didSelectShowAllRate;

@end

@interface FMPageInfoAllRateCell : UITableViewCell

@property (weak, nonatomic) id<FMPageInfoAllRateCellDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
