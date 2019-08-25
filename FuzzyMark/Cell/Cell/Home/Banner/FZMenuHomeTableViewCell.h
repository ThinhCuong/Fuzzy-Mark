//
//  FZMenuHomeTableViewCell.h
//  FuzzyMark
//
//  Created by Nguyen Cuong on 4/15/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FZHomeObject.h"

typedef NS_ENUM(NSUInteger, SuportList) {
    Category_Suport = 0,
    Sale_Suport,
    Hotline_Suport,
    SNews_Suport
};

typedef NS_ENUM(NSUInteger, CategoryList) {
    Restaurant_Category = 0,
    Hotel_Category,
    Travel_Category,
    Store_Category,
    News_Category,
    Map_Category
};

NS_ASSUME_NONNULL_BEGIN
@protocol FZMenuHomeTableViewDelegate <NSObject>

- (void)didSelectSuportList:(SuportList ) indexChoose;
- (void)didSelectCategoryList:(CategoryList ) indexChoose;
- (void)clickToHotline;
- (void)clickReward;
- (void)clickNews;

@end


@interface FZMenuHomeTableViewCell : UITableViewCell

@property (assign, nonatomic) id<FZMenuHomeTableViewDelegate> delegate;
- (void)bindData:(FZHomeObject *)homeData;

@end

NS_ASSUME_NONNULL_END
