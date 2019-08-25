//
//  FZVouchersSearchModel.m
//  FuzzyMark
//
//  Created by Tu Tran on 8/25/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import "FZVouchersSearchModel.h"
#import "FZHomeModel.h"



@implementation FZVouchersSearchModel {
    NSInteger _categories;
    NSArray *_services;
    NSInteger _lat;
    NSInteger _lng;
    NSString *_keyword;
}

- (void)getDataTableView:(NSMutableDictionary *) params {
    NSDictionary *newParams = [self addNewKeyInDictionary:params];
    [self.httpClient getDataWithPath:GET_VOUCHERS_SEARCH andParam:newParams isSendToken:YES isShowfailureAlert:YES withSuccessBlock:^(id _Nullable success) {
        if([success isKindOfClass:[NSDictionary class]]) {
            if ([success codeForKey:@"error_code"] != 0) {
                [CommonFunction showToast:[success stringForKey:@"message"]];
            }
            NSInteger numberItem = [success arrayForKey:@"data"].count;
            self.isLoadMore = numberItem >= 50;
            if(numberItem > 0) {
                for (NSDictionary *dict in [success arrayForKey:@"data"]) {
                    RewardObject *obj = [[RewardObject alloc] initWithDataDictionary:dict];
                    [self.listItem addObject:obj];
                }
                [self.delegate updateViewDataSuccess:self.listItem];
            } else {
                [self.delegate updateViewDataEmpty];
            }
        } else {
            [self.delegate updateViewDataError];
        }
    } withFailBlock:^(id _Nullable fail) {
        [self.delegate updateViewDataError];
    }];
}

- (NSDictionary *)addNewKeyInDictionary:(NSDictionary *) dict {
    NSDictionary *newDict = dict.mutableCopy;
    
    NSString *categories = [self getStringWithArray:self.dataUpload.categories?:@[]];
    NSString *services = [self getStringWithArray:self.dataUpload.service?:@[]];
    
    [newDict setValue:self.dataUpload.keyword?:@"" forKey:@"keyword"];
    [newDict setValue:@(_lng) forKey:@"lng"];
    [newDict setValue:@(_lat) forKey:@"lat"];
    [newDict setValue:categories?:@"" forKey:@"categories"];
    [newDict setValue:services?:@"" forKey:@"services"];

    return newDict.copy;
}

- (NSString *)getStringWithArray:(NSArray <NSNumber*> *) arr {
    NSMutableString *dataString = [NSMutableString new];
    for (NSNumber *item in arr) {
        @try {
            [dataString appendString:[item stringValue]];
        } @catch (NSException *exception) {
            continue;
        } @finally {
            [dataString appendString:@","];
        }
    }
    if (dataString.length > 0) {
        [dataString substringFromIndex:dataString.length-1];
    }
    return dataString;
}

@end

@implementation FZUploadDataVoucher


@end
