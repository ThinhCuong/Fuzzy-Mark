//
//  FMCellBlockObject.h
//  FuzzyMark
//
//  Created by Tu Tran on 5/2/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger, FMTableViewCellBlock) {
    FMTableViewCellBlockUserInfor,
    FMTableViewCellBlockFavoritePlaces,
    FMTableViewCellBlockChangePassWord,
    FMTableViewCellBlockChangePhoneNumber,
    FMTableViewCellBlockPoliciesAndTerms,
    FMTableViewCellBlockLogOut
};

NS_ASSUME_NONNULL_BEGIN

@interface FMCellBlockObject : NSObject
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) UIImage *image;
@property (assign, nonatomic) FMTableViewCellBlock typeBlock;
@end

NS_ASSUME_NONNULL_END
