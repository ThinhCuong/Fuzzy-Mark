//
//  FMNewsViewTableViewCell.h
//  FuzzyMark
//
//  Created by Tu Tran on 9/7/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FZNewsObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface FMNewsViewTableViewCell : UITableViewCell <UICollectionViewDelegate, UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

- (void)binDataWithListNewRelate:(NSArray *) array;

@end

NS_ASSUME_NONNULL_END
