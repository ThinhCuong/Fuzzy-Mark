
#import "NSDictionary+Helper.h"

#define UNKNOWN_CODE                -666

@implementation NSDictionary (Helper)

- (NSInteger)codeForKey:(NSString *)key {
    @try {
        if ([self existKey:key]) {
            id value = self[key];
            if([value isKindOfClass:[NSNumber class]]) {
                return [value integerValue];
            } else if ([value isKindOfClass:[NSString class]]) {
                NSString *stringValue = value;
                if(stringValue.length > 0) {
                    return [stringValue integerValue];
                } else {
                    return UNKNOWN_CODE;
                }
            }
        }
        return UNKNOWN_CODE;
    } @catch (NSException *exception) {
        return UNKNOWN_CODE;
    }
}

- (NSDictionary *)dictionaryForKey:(NSString *)key {
    @try {
        if([self existKey:key]) {
            id value = self[key];
            if ([value isKindOfClass:[NSDictionary class]]) {
                return value;
            }
        }
        return @{};
    } @catch (NSException *exception) {
        return @{};
    }
}

- (NSArray *)arrayForKey:(NSString *)key {
    @try {
        if ([self existKey:key]) {
            id value = self[key];
            if ([value isKindOfClass:[NSArray class]]) {
                return value;
            }
        }
        return @[];
    } @catch (NSException *exception) {
        return @[];
    }
    
}

- (NSString *)stringForKey:(NSString *)key {
    @try {
        if ([self existKey:key]) {
            id value = self[key];
            if([value isKindOfClass:[NSString class]]) {
                return value;
            }
            if([value isKindOfClass:[NSNumber class]]) {
                return [value stringValue];
            }
        }
        return @"";
    } @catch (NSException *exception) {
        return @"";
    }
}

- (NSString *)stringImageForKey:(NSString *)key {
    @try {
        if ([self existKey:key]) {
            id value = self[key];
            if([value isKindOfClass:[NSString class]]) {
                return [value stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
            }
            if([value isKindOfClass:[NSNumber class]]) {
                return [[value stringValue] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
            }
        }
        return @"";
    } @catch (NSException *exception) {
        return @"";
    }
}

- (NSInteger)integerForKey:(NSString *)key {
    @try {
        if([self existKey:key]) {
            id value = self[key];
            if([value isKindOfClass:[NSNumber class]]) {
                return [value integerValue];
            } else if([value isKindOfClass:[NSString class]]) {
                return [value integerValue];
            }
        }
        return 0;
    } @catch (NSException *exception) {
        return 0;
    }
}

- (float)floatForKey:(NSString *)key {
    @try {
        if ([self existKey:key]) {
            id value = self[key];
            if([value isKindOfClass:[NSNumber class]]) {
                return [value floatValue];
            } else if([value isKindOfClass:[NSString class]]) {
                return [value floatValue];
            }
        }
        return 0;
    } @catch (NSException *exception) {
        return 0;
    }
}

- (double)doubleForKey:(NSString *)key {
    @try {
        if([self existKey:key]) {
            id value = self[key];
            if([value isKindOfClass:[NSNumber class]]) {
                return [value doubleValue];
            } else if([value isKindOfClass:[NSString class]]) {
                return [value doubleValue];
            }
        }
        return 0;
    } @catch (NSException *exception) {
        return 0;
    }
}


- (BOOL)boolForKey:(NSString *)key {
    @try {
        if([self existKey:key]) {
            id value = self[key];
            if([value isKindOfClass:[NSNumber class]]) {
                return [value boolValue];
            } else if([value isKindOfClass:[NSString class]]) {
                return [value boolValue];
            }
        }
        return NO;
    } @catch (NSException *exception) {
        return NO;
    }
}

- (BOOL)existKey:(NSString *)key {
    BOOL retVal = 0;
    NSArray *allKeys = [self allKeys];
    retVal = [allKeys containsObject:key];
    return retVal;
}

- (BOOL)isEmpty {
    NSArray *allKeys = [self allKeys];
    if(allKeys.count == 0) {
        return YES;
    }
    return NO;
}

@end
