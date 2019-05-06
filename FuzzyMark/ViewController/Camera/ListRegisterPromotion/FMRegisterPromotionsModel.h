//
//  FMRegisterPromotionsModel.h
//  FuzzyMark
//
//  Created by Tu Tran on 5/4/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FMRegisterPromotionsModel : NSObject
@property (strong, nonatomic) NSMutableArray *listData;
- (void)getListHistoryCaptureWithSuccessBlock: (void(^)(id)) successBlock;

@end

NS_ASSUME_NONNULL_END
