//
//  FMUserInforModel.h
//  FuzzyMark
//
//  Created by Tu Tran on 5/2/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@protocol FMUserInforDelegate <NSObject>
- (void)reLoadBlockCell:(NSArray *) listMenuBlock;
- (void)reLoadUserCell:(UserInformation *) userInfo;
@end

@interface FMUserInforModel : NSObject
- (void)loadData;
@property (assign, nonatomic ) id<FMUserInforDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
