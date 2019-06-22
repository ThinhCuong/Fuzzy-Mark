//
//  FZHomeHeaderView.h
//  FuzzyMark
//
//  Created by Nguyen Cuong on 4/15/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol FZHomeHeaderDelegate <NSObject>

- (void)showPickerChooseLocation;

@end

@interface FZHomeHeaderView : UITableViewHeaderFooterView

@property (assign, nonatomic) id<FZHomeHeaderDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
