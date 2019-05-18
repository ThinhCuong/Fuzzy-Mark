//
//  NotifiModel.m
//  FuzzyMark
//
//  Created by Tu Tran on 5/19/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import "Notifi.h"

@implementation Notifi

+ (JSONKeyMapper *)keyMapper {
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{
                                                                  @"idNoti": @"id", @"descriptions": @"description"
                                                                  }];
}

@end
