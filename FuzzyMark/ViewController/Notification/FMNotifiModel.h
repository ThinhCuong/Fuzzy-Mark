//
//  FMNotifiModel.h
//  FuzzyMark
//
//  Created by Tu Tran on 5/19/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@protocol FMNotifiModel <NSObject>

- (void)updateData:(NSArray *) listData;

@end
@interface FMNotifiModel : NSObject

@property (assign, nonatomic) id<FMNotifiModel> delegate;

@end

NS_ASSUME_NONNULL_END
