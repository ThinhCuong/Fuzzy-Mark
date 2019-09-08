//
//  FZNewsContentTableViewCell.h
//  FuzzyMark
//
//  Created by Nguyen Cuong on 8/26/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FZNewsContentTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

- (void)bindData:(NSString *)content title:(NSString *) title;

@end

NS_ASSUME_NONNULL_END
