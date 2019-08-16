//
//  HistoryCaptureObject.m
//  FuzzyMark
//
//  Created by Tu Tran on 8/16/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import "HistoryCaptureObject.h"

@implementation HistoryCaptureObject

- (instancetype)initWithDataDictionary:(NSDictionary *) dict
{
    self = [super init];
    if (self) {
        self.title = [dict stringForKey:@"title"];
        self.time = [dict stringForKey:@"time"];
        self.is_reward = [dict boolForKey:@"is_reward"];
        self.point = [dict integerForKey:@"point"];
    }
    return self;
}

@end
