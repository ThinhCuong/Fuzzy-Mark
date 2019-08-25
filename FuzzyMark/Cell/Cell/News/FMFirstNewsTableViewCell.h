//
//  FMFirstNewsTableViewCell.h
//  FuzzyMark
//
//  Created by Tu Tran on 4/17/19.
//  Copyright © 2019 Tu Tran. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FZNewsObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface FMFirstNewsTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *widthOfImage;

- (void)bindData:(FZNewsObject *)newsInfo isNewsDetail:(BOOL)isNewsDetail;
    
@end

NS_ASSUME_NONNULL_END
