//
//  UserInformation.m
//  FuzzyMark
//
//  Created by Tu Tran on 7/21/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import "UserInformation.h"

@implementation UseView

- (instancetype)initWithDict:(NSDictionary *) dict
{
    self = [super init];
    if (self) {
        self.idUser = [dict integerForKey:@"id"];
        self.name = [dict stringForKey:@"name"];
        self.avatar = [dict stringForKey:@"avatar"];
    }
    return self;
}

@end

@implementation UserInformation

- (instancetype)initWithDict:(NSDictionary *) dict
{
    self = [super init];
    if (self) {
        self.user_view = [[UseView alloc] initWithDict:[dict dictionaryForKey:@"user_view"]];
        self.email = [dict stringForKey:@"email"];
        self.phone = [dict stringForKey:@"phone"];
        self.point_reward = [dict integerForKey:@"point_reward"];
        self.history_count = [dict integerForKey:@"history_count"];
        self.token = [dict stringForKey:@"token"];
    }
    return self;
}

@end
