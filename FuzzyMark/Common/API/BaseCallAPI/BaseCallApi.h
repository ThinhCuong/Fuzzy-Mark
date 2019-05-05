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

- (instancetype)initWithBaseURL;

- (void)getDataWithPath:(NSString *)path
               andParam:(NSDictionary*)param
     isShowfailureAlert:(BOOL)isShowfailureAlert
       withSuccessBlock:(void(^)(id))successBlock
          withFailBlock:(void(^)(id))failureBlock;

- (void)postDataWithPath:(NSString *)path
                andParam:(NSDictionary*)param
      isShowfailureAlert:(BOOL)isShowfailureAlert
   withSuccessBlock:(void(^)(id))successBlock
           withFailBlock:(void(^)(id))failureBlock;

- (void)putDataWithPath:(NSString *)path
               andParam:(NSDictionary*)param
     isShowfailureAlert:(BOOL)isShowfailureAlert
       withSuccessBlock:(void(^)(id))successBlock
          withFailBlock:(void(^)(id))failureBlock;

- (void)deleteDataWithPath:(NSString *)path
                  andParam:(NSDictionary*)param
        isShowfailureAlert:(BOOL)isShowfailureAlert
          withSuccessBlock:(void(^)(id))successBlock
             withFailBlock:(void(^)(id))failureBlock;

@end
