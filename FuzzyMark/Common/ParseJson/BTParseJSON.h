//
//  BTParseJSON.h
//  BooxTown
//
//  Created by minhdv on 9/29/16.
//  Copyright © 2016 Huy Pham. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BTParseJSON : NSObject
- (instancetype)initWithDict:(NSDictionary*)dict;
- (BOOL)checkNullForKey:(NSString*)key;
- (NSString*)stringForKey:(NSString*)key;
- (BOOL)boolForKey:(NSString*)key;
- (NSInteger)integerForKey:(NSString*)key;
- (NSArray*)arrayForKey:(NSString*)key;
- (float)floatForKey:(NSString*)key;
- (double)doubleForKey:(NSString*)key;
- (NSDate*)dateForKey:(NSString*)key;
@end
