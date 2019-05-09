//
//  FZHomeJsonModel.m
//  FuzzyMark
//
//  Created by Nguyen Cuong on 5/6/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import "FZHomeJsonModel.h"

@implementation FZHomeJsonModel

@end


@implementation FZBannerModel

@end

@implementation FZFixedAdsJsonModel

@end

@implementation FZIconGroupJsonModel

@end

@implementation FZGroupJsonModel

@end

@implementation FZGroupInfoJsonModel

+ (JSONKeyMapper *)keyMapper {
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{
                                                                  @"groupInfoDescription": @"description",
                                                                  }];
}

@end

@implementation FZPageJsonModel

@end

@implementation FZLocationJsonModel

@end
