//
//  FMListItemImageVC.h
//  FuzzyMark
//
//  Created by Tu Tran on 8/30/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FMBaseListItemVC.h"
#import "PageInfo.h"

NS_ASSUME_NONNULL_BEGIN

@interface FMListItemImageVC : FMBaseListItemVC

- (instancetype)initWithListImage:(NSArray <AlbumView*> *) albums;

@end

NS_ASSUME_NONNULL_END
