//
//  MVPromotionDetailModel.h
//  FuzzyMark
//
//  Created by Tu Tran on 6/16/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VoucherInfoJsonModel.h"
#import "PageInfo.h"

NS_ASSUME_NONNULL_BEGIN
@protocol FMPageDetailModelDelegate <NSObject>

- (void)getDataSuccess:(PageInfo *) pageInfo;
- (void)getDataFail;
- (void)getDataError;

@end
@interface FMPageDetailModel : NSObject

@property (assign, nonatomic) id<FMPageDetailModelDelegate> delegate;

- (void)getPageInfoWithIDPage:(NSInteger)idPage;
- (void)addPageInterested:(NSInteger) idPage withSuccessBlock:(void (^) (BOOL)) successBlock;
- (void)deletePageInterested:(NSInteger) idPage withSuccessBlock:(void (^) (BOOL)) failBlock;

@end

NS_ASSUME_NONNULL_END
