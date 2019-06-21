//
//  FMListItemIntroduceVC.h
//  FuzzyMark
//
//  Created by Tu Tran on 6/20/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VoucherInfoJsonModel.h"
#import "FMBaseListItemVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface FMListItemIntroduceVC : FMBaseListItemVC

- (instancetype)initWithVoucherDataJson:(VoucherInfoJsonModel *) jsonModel;;

@end

NS_ASSUME_NONNULL_END
