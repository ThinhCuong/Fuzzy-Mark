//
//  FZBannerCollectionViewCell.h
//  FuzzyMark
//
//  Created by Nguyen Cuong on 5/12/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FZHomeJsonModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface FZBannerCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) IBOutlet UIImageView *bannerImage;

- (void)bindData:(FZBannerModel *)bannerInfo;

@end

NS_ASSUME_NONNULL_END
