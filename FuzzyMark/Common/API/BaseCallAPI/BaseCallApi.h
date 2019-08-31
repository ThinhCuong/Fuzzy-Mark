//
//  BaseCallApi.h
//  FuzzyMark
//
//  Created by Nguyen Cuong on 4/14/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPSessionManager.h"

@interface BaseCallApi : AFHTTPSessionManager

+ (BaseCallApi * _Nonnull)defaultInitWithBaseURL;

- (instancetype _Nonnull)initWithBaseURL:(NSString * _Nullable)baseUrl;

- (void)getDataWithPath:(NSString * _Nullable)path
               andParam:(NSDictionary * _Nullable)param
     isShowfailureAlert:(BOOL)isShowfailureAlert
       withSuccessBlock:(void(^ _Nullable)(id _Nullable))successBlock
          withFailBlock:(void(^ _Nullable)(id _Nullable))failureBlock;

- (void)getDataWithPath:(NSString * _Nullable)path
               andParam:(NSDictionary * _Nullable)param
            isSendToken:(BOOL)isSendToken
     isShowfailureAlert:(BOOL)isShowfailureAlert
       withSuccessBlock:(void(^ _Nullable)(id _Nullable))successBlock
          withFailBlock:(void(^ _Nullable)(id _Nullable))failureBlock;

- (void)postDataWithPath:(NSString * _Nullable)path
                andParam:(NSDictionary* _Nullable)param
      isShowfailureAlert:(BOOL)isShowfailureAlert
        withSuccessBlock:(void(^ _Nullable)(id _Nullable))successBlock
           withFailBlock:(void(^ _Nullable)(id _Nullable))failureBlock;

- (void)postDataWithPath:(NSString * _Nullable)path
                andParam:(NSDictionary* _Nullable)param
             isSendToken:(BOOL)isSendToken
      isShowfailureAlert:(BOOL)isShowfailureAlert
        withSuccessBlock:(void(^ _Nullable)(id _Nullable))successBlock
           withFailBlock:(void(^ _Nullable)(id _Nullable))failureBlock;

- (void)postDataWithPath:(NSString * _Nullable)path
            queriesParam:(NSDictionary * _Nullable)queriesParam
               bodyParam:(NSDictionary * _Nullable)bodyParam
constructingBodyWithBlock:(nullable void (^)(id<AFMultipartFormData> _Nonnull))block
             isSendToken:(BOOL)isSendToken
      isShowfailureAlert:(BOOL)isShowfailureAlert
        withSuccessBlock:(void(^ _Nullable)(id _Nullable))successBlock
           withFailBlock:(void(^ _Nullable)(id _Nullable))failureBlock;

- (void)putDataWithPath:(NSString * _Nullable)path
               andParam:(NSDictionary * _Nullable)param
     isShowfailureAlert:(BOOL)isShowfailureAlert
       withSuccessBlock:(void(^ _Nullable)(id _Nullable))successBlock
          withFailBlock:(void(^ _Nullable)(id _Nullable))failureBlock;

- (void)putDataWithPath:(NSString * _Nullable)path
               andParam:(NSDictionary * _Nullable)param
            isSendToken:(BOOL)isSendToken
     isShowfailureAlert:(BOOL)isShowfailureAlert
       withSuccessBlock:(void(^ _Nullable)(id _Nullable))successBlock
          withFailBlock:(void(^ _Nullable)(id _Nullable))failureBlock;

- (void)deleteDataWithPath:(NSString * _Nullable)path
                  andParam:(NSDictionary* _Nullable)param
               isSendToken:(BOOL)isSendToken
        isShowfailureAlert:(BOOL)isShowfailureAlert
          withSuccessBlock:(void(^ _Nullable)(id _Nullable))successBlock
             withFailBlock:(void(^ _Nullable)(id _Nullable))failureBlock;

@end
