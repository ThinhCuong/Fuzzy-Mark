//
//  FZVourchersSearchViewController.h
//  FuzzyMark
//
//  Created by Nguyen Cuong on 6/13/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FMVouchersObjecRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface FZVourchersSearchViewController : FMBaseViewController

@property (strong, nonatomic) NSString *placeholderSearchBar;
- (instancetype)initWithObjectRequest:(FMVouchersObjecRequest *) objRequest;

@end

NS_ASSUME_NONNULL_END
