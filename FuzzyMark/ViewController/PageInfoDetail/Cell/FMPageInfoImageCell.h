//
//  FMPageInfoImageCell.h
//  FuzzyMark
//
//  Created by Tu Tran on 8/30/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PageInfo.h"

NS_ASSUME_NONNULL_BEGIN

@interface FMPageInfoImageCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *lbName;
@property (weak, nonatomic) IBOutlet UILabel *lbNumberImage;
@property (weak, nonatomic) IBOutlet UIImageView *imgContent;
- (void)binDataWithAlbum:(AlbumView *) album;
@end

NS_ASSUME_NONNULL_END
