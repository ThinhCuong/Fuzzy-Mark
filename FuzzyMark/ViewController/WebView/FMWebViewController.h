//
//  FMWebViewController.h
//  FuzzyMark
//
//  Created by Tu Tran on 9/5/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FMWebViewController : FMBaseViewController

- (instancetype)initWithLink:(NSString *) url andTitle:(NSString *) title;

@end

NS_ASSUME_NONNULL_END
