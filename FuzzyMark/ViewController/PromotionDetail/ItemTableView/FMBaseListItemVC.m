//
//  FMBaseListItemVC.m
//  FuzzyMark
//
//  Created by Tu Tran on 6/21/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import "FMBaseListItemVC.h"

@interface FMBaseListItemVC () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation FMBaseListItemVC

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.changeHeightContentTableView(self.contentTableView.contentSize.height);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [UITableViewCell new];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if([indexPath row] == ((NSIndexPath*)[[tableView indexPathsForVisibleRows] lastObject]).row){
        self.changeHeightContentTableView(self.contentTableView.contentSize.height);
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"Click cell");
}

@end
