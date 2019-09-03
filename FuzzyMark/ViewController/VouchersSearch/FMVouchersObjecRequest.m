//
//  FMVouchersObjecRequest.m
//  FuzzyMark
//
//  Created by Tu Tran on 9/2/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import "FMVouchersObjecRequest.h"

@implementation FMVouchersObjecRequest {
    NSMutableArray *_categoriesID;
    NSMutableArray *_servicesID;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _servicesID = [NSMutableArray new];
        _categoriesID = [NSMutableArray new];
    }
    return self;
}

- (void)addCategoryID:(NSInteger) categoryID {
    NSNumber *value = [NSNumber numberWithInteger:categoryID];
    if (![_categoriesID containsObject:value]) {
        [_categoriesID addObject:value];
    }
}

- (void)removeCategoryID:(NSInteger) categoryID {
    NSNumber *value = [NSNumber numberWithInteger:categoryID];
    NSInteger index = [_categoriesID indexOfObject:value];
    if (index != NSNotFound) {
        [_categoriesID removeObjectAtIndex:index];
    }
}

- (void)addSeviceID:(NSInteger) serviceID {
    NSNumber *value = [NSNumber numberWithInteger:serviceID];
    if (![_servicesID containsObject:value]) {
        [self willChangeValueForKey:@"countService"];
        [_servicesID addObject:value];
        [self didChangeValueForKey:@"countService"];
    }
}

- (void)removeSeviceID:(NSInteger) serviceID {
    NSNumber *value = [NSNumber numberWithInteger:serviceID];
    NSInteger index = [_categoriesID indexOfObject:value];
    if (index != NSNotFound) {
        [self willChangeValueForKey:@"countService"];
        [_categoriesID removeObjectAtIndex:index];
        [self didChangeValueForKey:@"countService"];
    }
}

- (NSDictionary *)getParamRequestWithLocation:(CLLocationCoordinate2D)currentLocation {
    
    NSString *lat = [[NSNumber numberWithDouble:currentLocation.latitude] stringValue];
    NSString *lng = [[NSNumber numberWithDouble:currentLocation.longitude] stringValue];
    
    NSString *categoriesStr = @"";
    for (int i = 0; i<_categoriesID.count; i++) {
        NSNumber *number = _categoriesID[i];
        NSString *string;
        if (i != _categoriesID.count - 1) {
            string = [[number stringValue] stringByAppendingString:@","];
        } else {
            string = [number stringValue];
        }
        categoriesStr = [categoriesStr stringByAppendingString:string];
    }
    
    NSString *servicesStr = @"";
    for (int i = 0; i<_categoriesID.count; i++) {
        NSNumber *number = _categoriesID[i];
        NSString *string;
        if (i != _categoriesID.count - 1) {
            string = [[number stringValue] stringByAppendingString:@","];
        } else {
            string = [number stringValue];
        }
        categoriesStr = [servicesStr stringByAppendingString:string];
    }
    
    NSDictionary *params = @{@"keyword": _keyword?:@"",
                             @"lat": lat?:@"",
                             @"lng": lng?:@"",
                             @"categories": categoriesStr?:@"",
                             @"services": servicesStr?:@""
                             };
    return params;
}

- (BOOL)checkServiceIsExistList:(NSInteger) serviceID {
    NSNumber *value = [NSNumber numberWithInteger:serviceID];
    NSInteger index = [_servicesID indexOfObject:value];
    if (index == NSNotFound) {
        return NO;
    } else {
        return YES;
    }
}

- (BOOL)checkCategoryIsExistList:(NSInteger) categoryID {
    NSNumber *value = [NSNumber numberWithInteger:categoryID];
    NSInteger index = [_categoriesID indexOfObject:value];
    if (index == NSNotFound) {
        return NO;
    } else {
        return YES;
    }
}

- (NSArray<NSNumber *> *)categoriesID {
    return _categoriesID.copy;
}

- (NSArray<NSNumber *> *)servicesID {
    return _servicesID.copy;
}

- (NSInteger)countService {
    return _servicesID.count;
}

@end
