//
//  FZSearchModel.h
//  FuzzyMark
//
//  Created by Nguyen Cuong on 5/27/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import <JSONModel/JSONModel.h>

NS_ASSUME_NONNULL_BEGIN

@class GroupObject;
@protocol GroupObject;

@interface FZSearchModel : JSONModel

@property (nonatomic) NSArray <GroupObject *> <GroupObject> *data;

@end

@class CategoryObject;
@protocol CategoryObject;
@interface GroupObject : JSONModel

@property (nonatomic) NSInteger id;
@property (nonatomic) NSString *title;
@property (nonatomic) NSString *icon;
@property (nonatomic) NSArray <CategoryObject *> <CategoryObject> *categories;
@end

@interface CategoryObject : JSONModel

@property (nonatomic) NSInteger id;
@property (nonatomic) NSString *name;
@property (nonatomic) NSString *image;

@end

NS_ASSUME_NONNULL_END
