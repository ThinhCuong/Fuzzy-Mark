//
//  UserInformation.m
//  FuzzyMark
//
//  Created by Tu Tran on 7/21/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import "UserInformation.h"

@implementation UseView
+ (JSONKeyMapper *)keyMapper {
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{
                                                                  @"idUser": @"id"
                                                                  }];
}
@end

@implementation UserInformation

@end
