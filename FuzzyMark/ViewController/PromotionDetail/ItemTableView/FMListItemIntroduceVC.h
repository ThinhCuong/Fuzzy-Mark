//
//  FMListItemIntroduceVC.h
//  FuzzyMark
//
//  Created by Tu Tran on 6/20/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VoucherInfoJsonModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface FMListItemIntroduceVC : UIViewController

- (instancetype)initWithVoucherDataJson:(VoucherInfoJsonModel *) jsonModel;;

@end

NS_ASSUME_NONNULL_END
