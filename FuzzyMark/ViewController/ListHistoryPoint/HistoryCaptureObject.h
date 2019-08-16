//
//  HistoryCaptureObject.h
//  FuzzyMark
//
//  Created by Tu Tran on 8/16/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HistoryCaptureObject : NSObject
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *time;
@property (assign, nonatomic) BOOL is_reward;
@property (assign, nonatomic) NSInteger point;
- (instancetype)initWithDataDictionary:(NSDictionary *) dict;
@end

NS_ASSUME_NONNULL_END
