//
//  FMHistoryBillViewController.m
//  FuzzyMark
//
//  Created by Tu Tran on 5/6/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import "FMHistoryBillViewController.h"
#import <HMSegmentedControl/HMSegmentedControl.h>
#import "FMItemHistoryBillVC.h"

@interface FMHistoryBillViewController () <UIPageViewControllerDelegate, UIPageViewControllerDataSource>
@property (weak, nonatomic) IBOutlet UIView *contentSegmentView;
@property (weak, nonatomic) IBOutlet UIView *contentPageView;

@end

@implementation FMHistoryBillViewController {
    HMSegmentedControl *_segmentedControl;
    UIPageViewController *_pageViewController;
    NSArray <UIViewController *> *_childTableVCs;
    NSInteger _currentIndex;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBar];
    [self setupSegmentControl];
    [self setupPageVC];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    _segmentedControl.frame = self.contentSegmentView.bounds;
    _pageViewController.view.frame = self.contentPageView.bounds;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.clipsToBounds = NO;
}

- (void)setNavigationBar {
    self.navigationItem.title = @"Lịch sử chụp hoá đơn";
    self.navigationController.navigationBar.topItem.title = @"";
    self.isHideNavigationBar = NO;
    self.navigationController.navigationBar.clipsToBounds = YES;
}

- (void)setupSegmentControl {
    _segmentedControl = [[HMSegmentedControl alloc] initWithSectionTitles:@[@"Chờ duyệt", @"Đã duyệt", @"Từ chối"]];
    _segmentedControl.segmentWidthStyle = HMSegmentedControlSegmentWidthStyleFixed;
    _segmentedControl.selectionStyle = HMSegmentedControlSelectionStyleTextWidthStripe;
    [_segmentedControl setSelectedSegmentIndex:0 animated:YES];
    _segmentedControl.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1.0], NSFontAttributeName : [UIFont fontWithName:@"Muli-SemiBold" size:14]};
    _segmentedControl.selectedTitleTextAttributes = @{NSForegroundColorAttributeName : [UIColor colorWithRed:0.2 green:0.6 blue:0.86 alpha:1.0], NSFontAttributeName : [UIFont fontWithName:@"Muli-SemiBold" size:14]};
    _segmentedControl.selectionIndicatorColor = [UIColor colorWithRed:0.2 green:0.6 blue:0.86 alpha:1.0];
    _segmentedControl.selectionIndicatorHeight = 2;
    _segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    _segmentedControl.backgroundColor = UIColor.whiteColor;
    [_segmentedControl addTarget:self action:@selector(segmentDidChangeIndex:) forControlEvents:UIControlEventValueChanged];
    [self.contentSegmentView addSubview:_segmentedControl];
}

- (void)setupPageVC {
    _pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    _pageViewController.delegate = self;
    _pageViewController.dataSource = self;
    _pageViewController.doubleSided = YES;
    FMItemHistoryBillVC *firstVC = [[FMItemHistoryBillVC alloc] init];
    FMItemHistoryBillVC *secondVC = [[FMItemHistoryBillVC alloc] init];
    FMItemHistoryBillVC *thirdVC = [[FMItemHistoryBillVC alloc] init];
    _childTableVCs = [NSArray arrayWithObjects: firstVC, secondVC, thirdVC, nil];
    [_pageViewController setViewControllers:@[_childTableVCs[0]] direction:UIPageViewControllerNavigationDirectionReverse animated:NO completion:nil];
    [self addChildViewController:_pageViewController];
    [self.contentPageView addSubview:_pageViewController.view];
    [_pageViewController didMoveToParentViewController:self];
}

- (void)segmentDidChangeIndex:(UISegmentedControl*)segmentCon{
    UIPageViewControllerNavigationDirection direction;
    if (segmentCon.selectedSegmentIndex > _currentIndex) {
        direction = UIPageViewControllerNavigationDirectionForward;
    }else{
        direction = UIPageViewControllerNavigationDirectionReverse;
    }
    _currentIndex = segmentCon.selectedSegmentIndex;
    [_pageViewController setViewControllers:@[_childTableVCs[segmentCon.selectedSegmentIndex]] direction:direction animated:YES completion:nil];
}

#pragma - mark UIPageViewControllerDataSource
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    NSInteger index = [_childTableVCs indexOfObject:viewController];
    if(index > 0) {
        return _childTableVCs[index - 1];
    } else {
        return nil;
    }
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    NSInteger index = [_childTableVCs indexOfObject:viewController];
    if(index < _childTableVCs.count - 1) {
        return _childTableVCs[index + 1];
    } else {
        return nil;
    }
}

- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers{
    if (pendingViewControllers.count > 0) {
        UIViewController *vc = pendingViewControllers[0];
        _currentIndex = [_childTableVCs indexOfObject:vc];
        
    }
}
- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed{
    if (completed) {
        [_segmentedControl setSelectedSegmentIndex:_currentIndex animated:YES];
    }
}



@end
