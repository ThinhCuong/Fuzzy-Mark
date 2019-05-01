//
//  FMUserInforModel.h
//  FuzzyMark
//
//  Created by Tu Tran on 5/2/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FMUserInforModel : NSObject
- (void)initDataAllCellBlockWithSuccessBlock:(void(^)(NSArray *)) successBlock;
- (void)initDataFirstCellUserWithSuccessBlock:(void(^)(NSArray *)) successBlock;
@end

NS_ASSUME_NONNULL_END
