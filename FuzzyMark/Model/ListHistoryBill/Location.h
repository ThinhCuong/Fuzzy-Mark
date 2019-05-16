//
//  Location.h
//  FuzzyMark
//
//  Created by Tu Tran on 5/5/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Location : JSONModel

@property (nonatomic) CGFloat lat;
@property (nonatomic) CGFloat lng;

@end

NS_ASSUME_NONNULL_END
