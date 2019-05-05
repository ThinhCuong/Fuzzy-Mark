//
//  BTParseJSON.m
//  BooxTown
//
//  Created by minhdv on 9/29/16.
//  Copyright © 2016 Huy Pham. All rights reserved.
//

#import "BTParseJSON.h"
@interface BTParseJSON()
{
    NSDictionary *_dict;
}
@end
@implementation BTParseJSON
- (instancetype)initWithDict:(NSDictionary*)dict
{
    self = [super init];
    if (self) {
        id idDict = dict;
        if (idDict && idDict != [NSNull null] && [idDict isKindOfClass:[NSDictionary class]]) {
            _dict = dict;
        }else{
            _dict = @{};
        }
        
    }
    return self;
}

-(BOOL)checkNullForKey:(NSString*)key{
    if (_dict[key] && _dict[key] != [NSNull null]) {
        return NO;
    }else{
        return YES;
    }
}

- (NSString*)stringForKey:(NSString*)key{
    if ([self checkNullForKey:key]) {
        return @"";
    }else{
        return [NSString stringWithFormat:@"%@",_dict[key]];
    }
}
- (BOOL)boolForKey:(NSString*)key{
    if ([self checkNullForKey:key]) {
        return NO;
    }else{
        return [_dict[key] boolValue];
    }
}
- (NSInteger)integerForKey:(NSString*)key{
    if ([self checkNullForKey:key]) {
        return 0;
    }else{
        return [_dict[key] integerValue];
    }
}
- (NSArray*)arrayForKey:(NSString*)key{
    if ([self checkNullForKey:key] || ![_dict[key] isKindOfClass:[NSArray class]]) {
        return [NSArray array];
    }else{
        return _dict[key];
    }
}
- (float)floatForKey:(NSString*)key{
    if ([self checkNullForKey:key]) {
        return 0.;
    }else{
        return [_dict[key] floatValue];
    }
}
- (double)doubleForKey:(NSString *)key {
    if ([self checkNullForKey:key]) {
        return 0.;
    }else{
        return [_dict[key] doubleValue];
    }
}

-(NSDate*)dateForKey:(NSString*)key{
    if ([self checkNullForKey:key]) {
        return [NSDate dateWithTimeIntervalSince1970:0];
    }else{
        NSDateFormatter *rfc3339DateFormatter = [[NSDateFormatter alloc] init];
        [rfc3339DateFormatter setDateFormat:@"yyyy'-'MM'-'dd'T'HH':'mm':'ss.sss'Z'"];
        NSDate *date = [rfc3339DateFormatter dateFromString:_dict[key]];
        return date;
    }
}
@end
