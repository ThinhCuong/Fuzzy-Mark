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
    Category = 0,
    Sale,
    Hotline,
    SNews
};

typedef NS_ENUM(NSUInteger, CategoryList) {
    Restaurant = 0,
    Hotel,
    Travel,
    Store,
    News,
    Map
};

NS_ASSUME_NONNULL_BEGIN
@protocol FZMenuHomeTableViewDelegate <NSObject>

- (void)didSelectSuportList:(SuportList ) indexChoose;
- (void)didSelectCategoryList:(CategoryList ) indexChoose;
- (void)clickToHotline;

@end


@interface FZMenuHomeTableViewCell : UITableViewCell

@property (assign, nonatomic) id<FZMenuHomeTableViewDelegate> delegate;
- (void)bindData:(FZHomeObject *)homeData;

@end

NS_ASSUME_NONNULL_END
