//
//  FMNewsCollectionViewCell.h
//  FuzzyMark
//
//  Created by Tu Tran on 4/17/19.
//  Copyright © 2019 Tu Tran. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FZNewsObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface FMNewsCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *newsImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

- (void)bindData:(FZNewsObject *)newsInfo;

@end

NS_ASSUME_NONNULL_END
