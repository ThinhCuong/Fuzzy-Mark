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

- (instancetype)initWithBaseURL {
    self = [super initWithBaseURL:[NSURL URLWithString:@"https://devtools-ntt.herokuapp.com/api/FuzzyMark/"]];
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


- (void)getDataWithPath:(NSString *)path
               andParam:(NSDictionary*)param
     isShowfailureAlert:(BOOL)isShowfailureAlert
       withSuccessBlock:(void(^)(id))successBlock
          withFailBlock:(void(^)(id))failureBlock {
    
    // init param with common param
    NSDictionary *newParams = [self createCommonParam:param];
    
    NSURLSessionDataTask *task = [self GET:path parameters:newParams progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        successBlock ? successBlock(responseObject) : 0;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureBlock ? failureBlock(error) : nil;
    }];
    
    [self.listTask addObject:task];
}

- (void)postDataWithPath:(NSString *)path
                andParam:(NSDictionary*)param
      isShowfailureAlert:(BOOL)isShowfailureAlert
        withSuccessBlock:(void(^)(id))successBlock
           withFailBlock:(void(^)(id))failureBlock {
    
    // init param with common param
    NSDictionary *newParams = [self createCommonParam:param];
    
    NSURLSessionDataTask *task = [self POST:path parameters:newParams progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        successBlock ? successBlock(responseObject) : 0;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureBlock ? failureBlock(error) : nil;
    }];
    
    [self.listTask addObject:task];
}

- (void)putDataWithPath:(NSString *)path
               andParam:(NSDictionary*)param
     isShowfailureAlert:(BOOL)isShowfailureAlert
       withSuccessBlock:(void(^)(id))successBlock
          withFailBlock:(void(^)(id))failureBlock {
    
    // init param with common param
    NSDictionary *newParams = [self createCommonParam:param];
    
    NSURLSessionDataTask *task = [self PUT:path parameters:newParams success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        successBlock ? successBlock(responseObject) : 0;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureBlock ? failureBlock(error) : nil;
    }];
    
    [self.listTask addObject:task];
}


- (void)deleteDataWithPath:(NSString *)path
                  andParam:(NSDictionary*)param
        isShowfailureAlert:(BOOL)isShowfailureAlert
          withSuccessBlock:(void(^)(id))successBlock
             withFailBlock:(void(^)(id))failureBlock {
    
    // init param with common param
    NSDictionary *newParams = [self createCommonParam:param];
    
    NSURLSessionDataTask *task = [self DELETE:path parameters:newParams success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
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
