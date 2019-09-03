//
//  MVUtilSearchViewController.h
//  FuzzyMark
//
//  Created by Tu Tran on 9/2/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FMVouchersObjecRequest.h"

NS_ASSUME_NONNULL_BEGIN

@class WrapService;
@interface MVUtilSearchViewController : FMBaseViewController

- (instancetype)initWith:(FMVouchersObjecRequest *) objRequest;

@end

@interface WrapService : NSObject

@property (strong, nonatomic) Service *service;
@property (assign, getter=isSelected,nonatomic) BOOL selected;

@end

NS_ASSUME_NONNULL_END
