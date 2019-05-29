//
//  FZItemSearchCollectionViewCell.h
//  FuzzyMark
//
//  Created by Nguyen Cuong on 5/28/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FZSearchModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface FZItemSearchCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) IBOutlet UIImageView *image;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;

- (void)bindData:(CategoryObject *)category;

@end

NS_ASSUME_NONNULL_END
