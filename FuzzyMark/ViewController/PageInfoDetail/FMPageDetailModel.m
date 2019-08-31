//
//  MVPromotionDetailModel.m
//  FuzzyMark
//
//  Created by Tu Tran on 6/16/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import "FMPromotionDetailModel.h"
#import "FMPageDetailModel.h"

@implementation FMPageDetailModel {
    BaseCallApi *_httpClient;
    
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _httpClient = [BaseCallApi defaultInitWithBaseURL];
    }
    return self;
}

- (void)getPageInfoWithIDPage:(NSInteger)idPage {
    NSDictionary *param = @{@"id": @(idPage)};
    [_httpClient getDataWithPath:GET_PAGES_INFO andParam:param isShowfailureAlert:YES withSuccessBlock:^(id success) {
        if(success) {
            if([success[@"errorCode"] integerValue] == 0) {
                PageInfo *pageInfo = [[PageInfo alloc] initWithDataDictionary:[success dictionaryForKey:@"data"]];
                
                [self.delegate getDataSuccess:pageInfo];
            } else {
                [self.delegate getDataError];
            }
        } else {
            [self.delegate getDataFail];
        }
    } withFailBlock:^(id fail) {
        [self.delegate getDataFail];
    }];
}

- (void)addPageInterested:(NSInteger) idPage pageName:(NSString *) pageName withSuccessBlock:(void (^) (BOOL)) successBlock {
    NSDictionary *param = @{@"id": @(idPage),
                            @"page_name": pageName?:@""
                            };
    [CommonFunction showLoadingView];
    [_httpClient postDataWithPath:POST_PAGES_ADD_INTERESTED andParam:param isSendToken:YES isShowfailureAlert:YES withSuccessBlock:nil withFailBlock:nil];
    [_httpClient postDataWithPath:POST_PAGES_ADD_INTERESTED andParam:param isShowfailureAlert:YES withSuccessBlock:^(id _Nullable success) {
        [CommonFunction hideLoadingView];
        if ([success isKindOfClass:NSDictionary.class]) {
            if ([success codeForKey:@"error_code"] == 0) {
                successBlock?successBlock(YES):0;
            } else {
                successBlock?successBlock(NO):0;
            }
        } else {
            successBlock?successBlock(NO):0;
        }
    } withFailBlock:^(id _Nullable fail) {
        [CommonFunction hideLoadingView];
        successBlock?successBlock(NO):0;
    }];
}

- (void)deletePageInterested:(NSInteger) idPage pageName:(NSString *) pageName withSuccessBlock:(void (^) (BOOL)) successBlock {
    NSDictionary *param = @{@"id": @(idPage),
                            @"page_name": pageName?:@""
                            };
    [CommonFunction showLoadingView];
    [_httpClient deleteDataWithPath:DELETE_PAGES_DELETE_INTERESTED andParam:param isSendToken:YES isShowfailureAlert:YES withSuccessBlock:nil withFailBlock:nil];
    [_httpClient deleteDataWithPath:DELETE_PAGES_DELETE_INTERESTED andParam:param isSendToken:YES isShowfailureAlert:YES withSuccessBlock:^(id _Nullable success) {
        [CommonFunction hideLoadingView];
        if ([success isKindOfClass:NSDictionary.class]) {
            if ([success codeForKey:@"error_code"] == 0) {
                successBlock?successBlock(YES):0;
            } else {
                successBlock?successBlock(NO):0;
            }
        } else {
            successBlock?successBlock(NO):0;
        }
    } withFailBlock:^(id _Nullable fail) {
        [CommonFunction hideLoadingView];
        successBlock?successBlock(NO):0;
    }];
}

@end
