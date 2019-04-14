//
//  BaseCallApi.m
//  FuzzyMark
//
//  Created by Nguyen Cuong on 4/14/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import "BaseCallApi.h"

@interface BaseCallApi()

@property (nonatomic, strong) NSMutableArray *arrayOfTasks;

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
        _arrayOfTasks = [NSMutableArray new];
    }
    return self;
}

- (void)postDataWithPath:(NSString *)path
                andParam:(NSDictionary*)param
        showFailureAlert:(BOOL)failureAlert
               withBlock:(void(^)(id))block
           withFailBlock:(void(^)(id))failBlock {
    
   // __weak NSString *savePath = path;
    NSDictionary *newParams = [self makeParamsWithDeviceInfo:param];
    
    NSURLSessionDataTask *task = [self POST:path parameters:newParams progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        block ? block(responseObject) : 0;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failBlock ? failBlock(error) : nil;
    }];
    
    [_arrayOfTasks addObject:task];
}

- (NSDictionary *)makeParamsWithDeviceInfo:(NSDictionary *)params {
    NSMutableDictionary *mutableParams = params.mutableCopy;
    [mutableParams setObject:@"ios" forKey:@"os_type"];
    return mutableParams;
}

@end
