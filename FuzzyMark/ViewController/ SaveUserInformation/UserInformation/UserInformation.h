//
//  UserInformation.h
//  FuzzyMark
//
//  Created by Tu Tran on 7/21/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UseView : NSObject
@property (assign, nonatomic) NSInteger idUser;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *avatar;
- (instancetype)initWithDict:(NSDictionary *) dict;
@end

@interface UserInformation : NSObject
@property (strong, nonatomic) UseView *user_view;
@property (strong, nonatomic) NSString *email;
@property (strong, nonatomic) NSString *phone;
@property (assign, nonatomic) NSInteger point_reward;
@property (assign, nonatomic) NSInteger history_count;
@property (strong, nonatomic) NSString *token;
- (instancetype)initWithDict:(NSDictionary *) dict;
@end

NS_ASSUME_NONNULL_END
