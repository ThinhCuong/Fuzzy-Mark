//
//  FMLoginCell.h
//  FuzzyMark
//
//  Created by Tu Tran on 7/29/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol FMLoginCellDelegate  <NSObject>
- (void)didSelectLogin;
@end

@interface FMLoginCell : UITableViewCell
@property (assign, nonatomic) id <FMLoginCellDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
