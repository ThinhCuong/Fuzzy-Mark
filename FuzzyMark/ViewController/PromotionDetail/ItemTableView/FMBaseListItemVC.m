//
//  FMBaseListItemVC.m
//  FuzzyMark
//
//  Created by Tu Tran on 6/21/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import "FMBaseListItemVC.h"

@interface FMBaseListItemVC ()

@end

@implementation FMBaseListItemVC

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.changeHeightContentTableView(self.contentTableView.contentSize.height);
}

@end
