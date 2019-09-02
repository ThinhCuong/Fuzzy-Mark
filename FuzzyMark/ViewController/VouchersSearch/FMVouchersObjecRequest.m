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
        [_servicesID addObject:value];
    }
}

- (void)removeSeviceID:(NSInteger) serviceID {
    NSNumber *value = [NSNumber numberWithInteger:serviceID];
    NSInteger index = [_categoriesID indexOfObject:value];
    if (index != NSNotFound) {
        [_categoriesID removeObjectAtIndex:index];
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

- (NSArray<NSNumber *> *)categoriesID {
    return _categoriesID.copy;
}

- (NSArray<NSNumber *> *)servicesID {
    return _servicesID.copy;
}

@end
