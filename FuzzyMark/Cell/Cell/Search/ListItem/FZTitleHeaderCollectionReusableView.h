//
//  FZTitleHeaderCollectionReusableView.h
//  FuzzyMark
//
//  Created by Nguyen Cuong on 5/30/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FZTitleHeaderCollectionReusableView : UICollectionReusableView

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;

- (void)bindData:(NSString *)title;

@end

NS_ASSUME_NONNULL_END
