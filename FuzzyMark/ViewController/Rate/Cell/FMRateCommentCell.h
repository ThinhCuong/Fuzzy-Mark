//
//  FMRateCommentCell.h
//  FuzzyMark
//
//  Created by Tu Tran on 9/8/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FMRateCommentCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *lbTitle;
@property (weak, nonatomic) IBOutlet UIView *boxView;
- (void)binData:(NSString *) text;
@end

NS_ASSUME_NONNULL_END
