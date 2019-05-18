//
//  NotifiModel.h
//  FuzzyMark
//
//  Created by Tu Tran on 5/19/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Notifi : JSONModel

@property (nonatomic) NSInteger idNoti;
@property (nonatomic) NSString *title;
@property (nonatomic) NSString *descriptions;
@property (nonatomic) NSInteger type;
@property (nonatomic) NSString *time;
@property (nonatomic) BOOL is_read;

@end

NS_ASSUME_NONNULL_END
