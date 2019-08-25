//
//  FZNewsObject.m
//  FuzzyMark
//
//  Created by Nguyen Cuong on 8/25/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import "FZNewsObject.h"

@implementation FZNewsObject

- (instancetype)initWithDataDictionary:(NSDictionary *)data {
    self = [super init];
    if (self) {
        self.newsId = [data integerForKey:@"id"];
        self.title = [data stringForKey:@"title"];
        self.image = [data stringForKey:@"image"];
        self.newsDescription = [data stringForKey:@"description"];
        self.time = [data stringForKey:@"time"];
    }
    return self;
}
@end
