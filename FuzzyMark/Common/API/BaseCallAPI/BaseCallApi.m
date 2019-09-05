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

NSInteger const kNetworkingTimeout = 30;

@implementation BaseCallApi

+ (BaseCallApi * _Nonnull)defaultInitWithBaseURL {
    static BaseCallApi *defaultInitWithBaseURL = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        defaultInitWithBaseURL = [[BaseCallApi alloc] initWithBaseURL:@"http://fuzzy.congculaptrinh.com/api/"];
//        defaultInitWithBaseURL = [[BaseCallApi alloc] initWithBaseURL:@"https://devtools-ntt.herokuapp.com/api/FuzzyMark/"];
    });
    return defaultInitWithBaseURL;
}

- (instancetype _Nonnull)initWithBaseURL:(NSString * _Nullable)baseUrl {
    self = [super initWithBaseURL:[NSURL URLWithString:baseUrl]];
    if (self) {
        self.responseSerializer = [AFJSONResponseSerializer serializer];
        self.requestSerializer = [AFHTTPRequestSerializer serializer];
          self.requestSerializer.timeoutInterval = kNetworkingTimeout;
        self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html", nil];
        self.securityPolicy.allowInvalidCertificates = YES;
        self.listTask = [NSMutableArray new];
    }
    return self;
}

- (void)getDataWithPath:(NSString * _Nullable)path
               andParam:(NSDictionary * _Nullable)param
     isShowfailureAlert:(BOOL)isShowfailureAlert
       withSuccessBlock:(void(^ _Nullable)(id _Nullable))successBlock
          withFailBlock:(void(^ _Nullable)(id _Nullable))failureBlock {
    
    [self getDataWithPath:path andParam:param isSendToken:NO isShowfailureAlert:isShowfailureAlert withSuccessBlock:successBlock withFailBlock:failureBlock];
}

- (void)getDataWithPath:(NSString * _Nullable)path
               andParam:(NSDictionary * _Nullable)param
            isSendToken:(BOOL)isSendToken
     isShowfailureAlert:(BOOL)isShowfailureAlert
       withSuccessBlock:(void(^ _Nullable)(id _Nullable))successBlock
          withFailBlock:(void(^ _Nullable)(id _Nullable))failureBlock {
    
    // init param with common param
    NSDictionary *newParams = [self createCommonParam:param];
    
    // send token
    if (isSendToken) {
        [self.requestSerializer setValue:[UserInfo getUserToken] forHTTPHeaderField:@"Authorization"];
    } else {
        [self.requestSerializer clearAuthorizationHeader];
    }
    
    NSURLSessionDataTask *task = [self GET:path parameters:newParams progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        successBlock ? successBlock(responseObject) : 0;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureBlock ? failureBlock(error) : nil;
    }];
    
    [self.listTask addObject:task];
}

- (void)postDataWithPath:(NSString * _Nullable)path
                andParam:(NSDictionary* _Nullable)param
      isShowfailureAlert:(BOOL)isShowfailureAlert
        withSuccessBlock:(void(^ _Nullable)(id _Nullable))successBlock
           withFailBlock:(void(^ _Nullable)(id _Nullable))failureBlock {
    
    // init param with common param
    NSDictionary *newParams = [self createCommonParam:param];
    
    NSURLSessionDataTask *task = [self POST:path parameters:newParams progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        successBlock ? successBlock(responseObject) : 0;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureBlock ? failureBlock(error) : nil;
    }];
    
    [self.listTask addObject:task];
}

- (void)postDataWithPath:(NSString * _Nullable)path
                andParam:(NSDictionary* _Nullable)param
             isSendToken:(BOOL)isSendToken
      isShowfailureAlert:(BOOL)isShowfailureAlert
        withSuccessBlock:(void(^ _Nullable)(id _Nullable))successBlock
           withFailBlock:(void(^ _Nullable)(id _Nullable))failureBlock {
    
    // init param with common param
    NSDictionary *newParams = [self createCommonParam:param];
    
    // send token
    if (isSendToken) {
        [self.requestSerializer setValue:[UserInfo getUserToken] forHTTPHeaderField:@"Authorization"];
    } else {
        [self.requestSerializer clearAuthorizationHeader];
    }
    
    NSURLSessionDataTask *task = [self POST:path parameters:newParams progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        successBlock ? successBlock(responseObject) : 0;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureBlock ? failureBlock(error) : nil;
    }];
    
    [self.listTask addObject:task];
}

- (void)postDataWithPath:(NSString * _Nullable)path
            queriesParam:(NSDictionary * _Nullable)queriesParam
               bodyParam:(NSDictionary * _Nullable)bodyParam
constructingBodyWithBlock:(nullable void (^)(id<AFMultipartFormData> _Nonnull))block
             isSendToken:(BOOL)isSendToken
      isShowfailureAlert:(BOOL)isShowfailureAlert
        withSuccessBlock:(void(^ _Nullable)(id _Nullable))successBlock
           withFailBlock:(void(^ _Nullable)(id _Nullable))failureBlock {
    
    // init param with common param
    NSDictionary *newBodyParam = [self createCommonParam:bodyParam];
    NSString *newPath = [self addQueryStringToUrlString:path withDictionary:queriesParam];
    
    // send token
    if (isSendToken) {
        [self.requestSerializer setValue:[UserInfo getUserToken] forHTTPHeaderField:@"Authorization"];
    } else {
        [self.requestSerializer clearAuthorizationHeader];
    }
    
    NSURLSessionDataTask *task = [self POST:newPath parameters:newBodyParam constructingBodyWithBlock:block progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        successBlock ? successBlock(responseObject) : 0;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureBlock ? failureBlock(error) : nil;
    }];
    
    [self.listTask addObject:task];
}

- (void)putDataWithPath:(NSString * _Nullable)path
               andParam:(NSDictionary * _Nullable)param
     isShowfailureAlert:(BOOL)isShowfailureAlert
       withSuccessBlock:(void(^ _Nullable)(id _Nullable))successBlock
          withFailBlock:(void(^ _Nullable)(id _Nullable))failureBlock {
    [self putDataWithPath:path andParam:param isSendToken:NO isShowfailureAlert:isShowfailureAlert withSuccessBlock:successBlock withFailBlock:failureBlock];
}

- (void)putDataWithPath:(NSString * _Nullable)path
               andParam:(NSDictionary * _Nullable)param
            isSendToken:(BOOL)isSendToken
     isShowfailureAlert:(BOOL)isShowfailureAlert
       withSuccessBlock:(void(^ _Nullable)(id _Nullable))successBlock
          withFailBlock:(void(^ _Nullable)(id _Nullable))failureBlock {
    
    // init param with common param
    NSDictionary *newParams = [self createCommonParam:param];
    
    // send token
    if (isSendToken) {
        [self.requestSerializer setValue:[UserInfo getUserToken] forHTTPHeaderField:@"Authorization"];
    } else {
        [self.requestSerializer clearAuthorizationHeader];
    }
    
    NSURLSessionDataTask *task = [self PUT:path parameters:newParams success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        successBlock ? successBlock(responseObject) : 0;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureBlock ? failureBlock(error) : nil;
    }];
    
    [self.listTask addObject:task];
}

- (void)deleteDataWithPath:(NSString * _Nullable)path
                  andParam:(NSDictionary* _Nullable)param
               isSendToken:(BOOL)isSendToken
        isShowfailureAlert:(BOOL)isShowfailureAlert
          withSuccessBlock:(void(^ _Nullable)(id _Nullable))successBlock
             withFailBlock:(void(^ _Nullable)(id _Nullable))failureBlock {
    
    // init param with common param
    NSDictionary *newParams = [self createCommonParam:param];
    
    // send token
    if (isSendToken) {
        [self.requestSerializer setValue:[UserInfo getUserToken] forHTTPHeaderField:@"Authorization"];
    } else {
        [self.requestSerializer clearAuthorizationHeader];
    }
    
    NSURLSessionDataTask *task = [self DELETE:path parameters:newParams success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        successBlock ? successBlock(responseObject) : 0;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureBlock ? failureBlock(error) : nil;
    }];
    
    [self.listTask addObject:task];
}

- (void)deleteDataWithPath:(NSString * _Nullable)path
                 bodyParam:(NSDictionary * _Nullable)bodyParam
               isSendToken:(BOOL)isSendToken
        isShowfailureAlert:(BOOL)isShowfailureAlert
          withSuccessBlock:(void(^ _Nullable)(id _Nullable))successBlock
             withFailBlock:(void(^ _Nullable)(id _Nullable))failureBlock {
    
    self.requestSerializer.HTTPMethodsEncodingParametersInURI = [NSSet setWithObjects:@"GET", @"HEAD", nil];
    
    // init param with common param
    NSDictionary *newParams = [self createCommonParam:bodyParam];
    
    // send token
    if (isSendToken) {
        [self.requestSerializer setValue:[UserInfo getUserToken] forHTTPHeaderField:@"Authorization"];
    } else {
        [self.requestSerializer clearAuthorizationHeader];
    }
    
    NSURLSessionDataTask *task = [self DELETE:path parameters:newParams success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.requestSerializer.HTTPMethodsEncodingParametersInURI = [NSSet setWithObjects:@"GET", @"HEAD", @"DELETE", nil];
        successBlock ? successBlock(responseObject) : 0;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        self.requestSerializer.HTTPMethodsEncodingParametersInURI = [NSSet setWithObjects:@"GET", @"HEAD", @"DELETE", nil];
        failureBlock ? failureBlock(error) : nil;
    }];
    
    [self.listTask addObject:task];
    
}

- (NSDictionary *)createCommonParam:(NSDictionary *)commonParam {
    NSMutableDictionary *listParam = commonParam.mutableCopy;
    return listParam;
}

- (NSString*)addQueryStringToUrlString:(NSString *)urlString withDictionary:(NSDictionary *)dictionary
{
    NSMutableString *urlWithQueryString = [[NSMutableString alloc] initWithString:urlString];
    
    for (id key in dictionary) {
        NSString *keyString = [key description];
        NSString *valueString = [[dictionary objectForKey:key] description];
        
        if ([urlWithQueryString rangeOfString:@"?"].location == NSNotFound) {
            [urlWithQueryString appendFormat:@"?%@=%@", keyString, valueString];
        } else {
            [urlWithQueryString appendFormat:@"&%@=%@", keyString, valueString];
        }
    }
    return urlWithQueryString;
}

@end
