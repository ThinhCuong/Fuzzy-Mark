//
//  FZHomeModel.m
//  FuzzyMark
//
//  Created by Nguyen Cuong on 4/15/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import "FZHomeModel.h"
#import "FZMenuHomeTableViewCell.h"
#import "FZItemMenuHomeTableViewCell.h"
#import "FZItemMenuVerticalTableViewCell.h"

@implementation FZHomeModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        // call api
    }
    return self;
}

- (void)registerCellForTableView:(UITableView *)tableView {
    [tableView registerNib:[UINib nibWithNibName:@"FZHomeHeaderView" bundle:nil] forHeaderFooterViewReuseIdentifier:@"FZHomeHeaderView"];
    [tableView registerNib:[UINib nibWithNibName:@"FZMenuHomeTableViewCell" bundle:nil] forCellReuseIdentifier:@"FZMenuHomeTableViewCell"];
    [tableView registerNib:[UINib nibWithNibName:@"FZItemMenuHomeTableViewCell" bundle:nil] forCellReuseIdentifier:@"FZItemMenuHomeTableViewCell"];
    [tableView registerNib:[UINib nibWithNibName:@"FZItemMenuVerticalTableViewCell" bundle:nil] forCellReuseIdentifier:@"FZItemMenuVerticalTableViewCell"];
}

- (NSInteger )numberOfSectionsInTableView {
    return 2;
}

- (NSInteger )numberOfRowsInSection:(NSInteger )section {
    switch (section) {
        case 0:
            return 1;
            break;
        default:
            return 2;
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        FZMenuHomeTableViewCell *menuHomeCell = [tableView dequeueReusableCellWithIdentifier:@"FZMenuHomeTableViewCell"];
        return menuHomeCell;
    } else {
        FZItemMenuHomeTableViewCell *itemMenuHomeCell = [tableView dequeueReusableCellWithIdentifier:@"FZItemMenuHomeTableViewCell"];
        [itemMenuHomeCell bindData];
        return itemMenuHomeCell;
    }
}

@end
