//
//  PageInfo.h
//  FuzzyMark
//
//  Created by Tu Tran on 8/30/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Voucher.h"
#import "FZHomeObject.h"

NS_ASSUME_NONNULL_BEGIN

@class RageView;
@class AlbumView;
@interface PageInfo : NSObject

@property (strong, nonatomic) PageObject *page_view;
@property (strong, nonatomic) Voucher *hot_voucher;
@property (strong, nonatomic) NSString *descriptionPageInfo;
@property (strong, nonatomic) NSString *short_description;
@property (strong, nonatomic) NSArray <Voucher*> *vouchers;
@property (strong, nonatomic) NSArray <RageView*> *rates;
@property (strong, nonatomic) NSArray <AlbumView*> *albums;
@property (assign, nonatomic) BOOL is_rate;
- (instancetype)initWithDataDictionary:(NSDictionary *) data;


@end

@interface RageView : NSObject

@property (strong, nonatomic) UseView *user;
@property (assign, nonatomic) NSInteger point;
@property (strong, nonatomic) NSString *comment;
@property (strong, nonatomic) NSString *time;
- (instancetype)initWithDataDictionary:(NSDictionary *) data;

@end

@interface AlbumView : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *type;
@property (strong, nonatomic) NSArray <NSString*> *files;
- (instancetype)initWithDataDictionary:(NSDictionary *) data;

@end

NS_ASSUME_NONNULL_END
