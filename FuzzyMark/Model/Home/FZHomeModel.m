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
#import "FZVourchersSearchViewController.h"

@interface FZHomeModel() {
    FZHomeObject *_homeData;
}

@end
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
}

- (void)bindData:(FZHomeObject *)homeData {
    _homeData = homeData;
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
            return _homeData.groups.count;
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        FZMenuHomeTableViewCell *menuHomeCell = [tableView dequeueReusableCellWithIdentifier:@"FZMenuHomeTableViewCell"];
        menuHomeCell.delegate = self.homeViewController;
        [menuHomeCell bindData:_homeData];
        return menuHomeCell;
    } else {
        FZItemMenuHomeTableViewCell *itemMenuHomeCell = [tableView dequeueReusableCellWithIdentifier:@"FZItemMenuHomeTableViewCell"];
        itemMenuHomeCell.delegate = self.homeViewController;
        [itemMenuHomeCell bindData:_homeData.groups[indexPath.row]];
        return itemMenuHomeCell;
    }
}

@end
