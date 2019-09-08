//
//  FZMenuHomeTableViewCell.h
//  FuzzyMark
//
//  Created by Nguyen Cuong on 4/15/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FZHomeObject.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, SuportList) {
    Category_Suport = 0,
    Sale_Suport = 1,
    Hotline_Suport = 2,
    SNews_Suport = 3
};

typedef NS_ENUM(NSInteger, FixCategory) {
    CategoryMap = -1,
    CategoryNew = -2
};

@protocol FZMenuHomeTableViewCellDelegate  <NSObject>

- (void)didSelectVoucherID:(NSInteger) voucherID;
- (void)didSelectSearchCategoryID:(NSInteger) categoryID;
- (void)didSelectSearchCategoryMap;
- (void)didSelectSearchCategoryNew;
- (void)didSelectSuportList:(SuportList) suportList;
- (void)didSelectWebviewWithLink:(NSString *) link andTitle:(NSString *) title;

@end

@interface FZMenuHomeTableViewCell : UITableViewCell

@property (nonatomic, assign) id<FZMenuHomeTableViewCellDelegate> delegate;
- (void)bindData:(FZHomeObject *)homeData;

@end

NS_ASSUME_NONNULL_END
