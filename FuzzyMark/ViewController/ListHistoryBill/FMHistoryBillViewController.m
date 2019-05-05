//
//  FMHistoryBillViewController.m
//  FuzzyMark
//
//  Created by Tu Tran on 5/6/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import "FMHistoryBillViewController.h"
#import <HMSegmentedControl/HMSegmentedControl.h>

@interface FMHistoryBillViewController ()
@property (weak, nonatomic) IBOutlet UIView *contentSegmentView;
@property (weak, nonatomic) IBOutlet UIView *contentPageView;

@end

@implementation FMHistoryBillViewController {
    HMSegmentedControl *_segmentedControl;
    UIPageViewController *_pageViewController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)setupSegmentControl {
    
}

- (void)setupPageVC {
    
}



@end
