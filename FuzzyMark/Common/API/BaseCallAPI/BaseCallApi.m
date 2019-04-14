//
//  BaseCallApi.m
//  FuzzyMark
//
//  Created by Nguyen Cuong on 4/14/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import "BaseCallApi.h"

@interface BaseCallApi()

@property (nonatomic, strong) NSMutableArray *listTask;

@end

@implementation BaseCallApi

- (instancetype)initWithBaseURL:(NSString *) baseUrl {
    self = [super initWithBaseURL:[NSURL URLWithString:baseUrl]];
    if (self) {
        self.responseSerializer = [AFJSONResponseSerializer serializer];
        self.requestSerializer = [AFHTTPRequestSerializer serializer];
      //  self.requestSerializer.timeoutInterval = kNetworkingTimeout;
        self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html", nil];
        self.securityPolicy.allowInvalidCertificates = YES;
        self.listTask = [NSMutableArray new];
    }
    return self;
}

- (void)postDataWithPath:(NSString *)path
                andParam:(NSDictionary*)param
        isShowfailureAlert:(BOOL)isShowfailureAlert
               withSuccessBlock:(void(^)(id))successBlock
           withFailBlock:(void(^)(id))failureBlock {
    
   // __weak NSString *savePath = path;
    NSDictionary *newParams = [self createCommonParam:param];
    
    NSURLSessionDataTask *task = [self POST:path parameters:newParams progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        successBlock ? successBlock(responseObject) : 0;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureBlock ? failureBlock(error) : nil;
    }];
    
    [self.listTask addObject:task];
}

- (NSDictionary *)createCommonParam:(NSDictionary *)commonParam {
    NSMutableDictionary *listParam = commonParam.mutableCopy;
    [listParam setObject:@"" forKey:@""];
    return listParam;
}

@end
