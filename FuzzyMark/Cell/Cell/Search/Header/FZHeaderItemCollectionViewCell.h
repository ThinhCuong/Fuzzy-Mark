//
//  FZHeaderItemCollectionViewCell.h
//  FuzzyMark
//
//  Created by Nguyen Cuong on 5/29/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FZSearchModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface FZHeaderItemCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) IBOutlet UIImageView *iconImage;
@property (strong, nonatomic) IBOutlet UIButton *backgroundIcon;
@property (strong, nonatomic) IBOutlet UIView *selectedLineView;

- (void)bindData:(GroupObject *)groupInfo;

@end

NS_ASSUME_NONNULL_END
