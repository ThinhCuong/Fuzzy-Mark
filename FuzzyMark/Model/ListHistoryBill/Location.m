//
//  Location.m
//  FuzzyMark
//
//  Created by Tu Tran on 5/5/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import "Location.h"

@implementation Location

- (instancetype)initWithDataDictionary:(NSDictionary *)data {
    self = [super init];
    if (self) {
        self.lat = [data floatForKey:@"lat"];
        self.lng = [data floatForKey:@"lng"];
    }
    return self;
}

@end
