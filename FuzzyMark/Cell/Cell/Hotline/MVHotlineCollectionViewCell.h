//
//  MVHotlineCollectionViewCell.h
//  FuzzyMark
//
//  Created by Nguyen Cuong on 6/23/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MVHotlineCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *tittleLabel;
@property (weak, nonatomic) IBOutlet UILabel *hotlineLabel;
@property (weak, nonatomic) IBOutlet UILabel *feeOfServiceLabel;

@end

NS_ASSUME_NONNULL_END
