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

+ (BaseCallApi *)defaultInitWithBaseURL {
    static BaseCallApi *defaultInitWithBaseURL = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        defaultInitWithBaseURL = [[BaseCallApi alloc] initWithBaseURL:@"http://fuzzy.congculaptrinh.com/api/"];
//        defaultInitWithBaseURL = [[BaseCallApi alloc] initWithBaseURL:@"https://devtools-ntt.herokuapp.com/api/FuzzyMark/"];
    });
    return defaultInitWithBaseURL;
}

- (instancetype)initWithBaseURL:(NSString *)baseUrl{
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

// Auto truyen token vao header moi API
- (NSURLSessionDataTask *)dataTaskWithRequest:(NSURLRequest *)request
                               uploadProgress:(nullable void (^)(NSProgress *uploadProgress)) uploadProgressBlock
                             downloadProgress:(nullable void (^)(NSProgress *downloadProgress)) downloadProgressBlock
                            completionHandler:(nullable void (^)(NSURLResponse *response, id _Nullable responseObject,  NSError * _Nullable error))completionHandler {
    
    static NSString *authorization;
    if(!authorization)
    {
        authorization = [UserInfo getUserToken];
    }
    
    NSMutableURLRequest *req = (NSMutableURLRequest *)request;
    [req setValue:authorization forHTTPHeaderField:@"Authorization"];
    return [super dataTaskWithRequest:request uploadProgress:uploadProgressBlock downloadProgress:downloadProgressBlock completionHandler:completionHandler];
}

- (NSDictionary *)createCommonParam:(NSDictionary *)commonParam {
    NSMutableDictionary *listParam = commonParam.mutableCopy;
    [listParam setObject:@"" forKey:@""];
    return listParam;
}

@end
