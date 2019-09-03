//
//  FMMenuHomeCategoryCell.h
//  FuzzyMark
//
//  Created by Tu Tran on 9/4/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FZHomeObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface FMMenuHomeCategoryCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imvCategory;
@property (weak, nonatomic) IBOutlet UILabel *lbCategory;
- (void)binDataWithIconGroup:(IConObject *) obj;
@end

NS_ASSUME_NONNULL_END
