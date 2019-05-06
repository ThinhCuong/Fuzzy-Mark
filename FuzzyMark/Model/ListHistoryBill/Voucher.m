//
//  Voucher.m
//  FuzzyMark
//
//  Created by Tu Tran on 5/5/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import "Voucher.h"

@implementation Voucher
- (instancetype)initWithDictionary:(NSDictionary *)dict error:(NSError *__autoreleasing *)err {
    self = [super initWithDictionary:dict error:err];
    if(self) {
        self.descriptions = dict[@"description"]?:@"";
    }
    return self;
}


@end
