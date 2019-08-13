//
//  FZHomeModel.h
//  FuzzyMark
//
//  Created by Nguyen Cuong on 4/15/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FZHomeViewController.h"
#import "FZHomeObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface FZHomeModel : NSObject

- (void)registerCellForTableView:(UITableView *)tableView;
- (NSInteger )numberOfSectionsInTableView;
- (NSInteger )numberOfRowsInSection:(NSInteger )section;
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

@property (strong, nonatomic) FZHomeViewController *homeViewController;

- (void)bindData:(FZHomeObject *)homeData;

@end

NS_ASSUME_NONNULL_END
