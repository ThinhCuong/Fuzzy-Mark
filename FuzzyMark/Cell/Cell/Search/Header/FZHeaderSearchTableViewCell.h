//
//  FZHeaderSearchTableViewCell.h
//  FuzzyMark
//
//  Created by Nguyen Cuong on 5/29/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConfigAppObject.h"

NS_ASSUME_NONNULL_BEGIN

@protocol FZHeaderSearchTableViewCellDelegate <NSObject>

- (void)didSelectItemCollectionViewAtIndexPath:(NSIndexPath *) indexPath;

@end
@interface FZHeaderSearchTableViewCell : UITableViewCell

- (void)bindData:(NSArray *)listGroup;

@property (assign, nonatomic) NSInteger sectionIndex;
@property (assign, nonatomic) id<FZHeaderSearchTableViewCellDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
