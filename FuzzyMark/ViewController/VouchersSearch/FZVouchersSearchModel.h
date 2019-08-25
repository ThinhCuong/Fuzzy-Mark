//
//  FZVouchersSearchModel.h
//  FuzzyMark
//
//  Created by Tu Tran on 8/25/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMBaseTableViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@class FZUploadDataVoucher;
@interface FZVouchersSearchModel : FMBaseTableViewModel
@property (strong, nonatomic) FZUploadDataVoucher *dataUpload;
@end

@interface FZUploadDataVoucher : NSObject
@property (strong, nonatomic) NSString *keyword;
@property (assign, nonatomic) NSInteger lat;
@property (assign, nonatomic) NSInteger lng;
@property (assign, nonatomic) NSArray <NSNumber*> *categories;
@property (assign, nonatomic) NSArray <NSNumber*> *service;

@end

NS_ASSUME_NONNULL_END
