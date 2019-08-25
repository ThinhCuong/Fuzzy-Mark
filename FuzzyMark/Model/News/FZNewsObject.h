//
//  FZNewsObject.h
//  FuzzyMark
//
//  Created by Nguyen Cuong on 8/25/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FZNewsObject : NSObject

@property (assign, nonatomic) NSInteger newsId;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *image;
@property (strong, nonatomic) NSString *newsDescription;
@property (strong, nonatomic) NSString *time;

- (instancetype)initWithDataDictionary:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
