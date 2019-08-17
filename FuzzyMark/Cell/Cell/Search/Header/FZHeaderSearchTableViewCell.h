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

@interface FZHeaderSearchTableViewCell : UITableViewCell

- (void)bindData:(NSArray *)listGroup;

@property (assign, nonatomic) NSInteger sectionIndex;

@end

NS_ASSUME_NONNULL_END
