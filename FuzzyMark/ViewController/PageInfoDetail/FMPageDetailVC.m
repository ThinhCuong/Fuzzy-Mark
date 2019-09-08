//
//  MVPromotionDetailVC.m
//  FuzzyMark
//
//  Created by Tu Tran on 6/16/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import "FMPageDetailVC.h"
#import "FMPageDetailModel.h"
#import "FMCameraViewController.h"
#import <HMSegmentedControl/HMSegmentedControl.h>
#import "FMListItemLocationVC.h"
#import "FMListItemIntroduceVC.h"
#import "FMListItemGiftVC.h"
#import "FMListItemImageVC.h"
#import "FMListItemRateVC.h"
#import "FzVourcherInfoObject.h"
#import "AppDelegate.h"
#import "FMRateViewController.h"

@interface FMPageDetailVC () <FMPageDetailModelDelegate, UIPageViewControllerDataSource, UIPageViewControllerDelegate, UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imgBanner;
@property (weak, nonatomic) IBOutlet UIImageView *imgPageInfo;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblDescription;
@property (weak, nonatomic) IBOutlet UILabel *lblTime;
@property (weak, nonatomic) IBOutlet UILabel *lbRate;
@property (weak, nonatomic) IBOutlet UIButton *btLike;
@property (weak, nonatomic) IBOutlet UIButton *btShare;
@property (weak, nonatomic) IBOutlet UIView *rateView;
@property (weak, nonatomic) IBOutlet UIView *contentSegmentView;
@property (weak, nonatomic) IBOutlet UIView *contentPageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintHeightPageView;

@property (strong, nonatomic) FMPageDetailModel *model;

@end

@implementation FMPageDetailVC {
    NSInteger _idPage;
    PageInfo *_pageInfo;
    HMSegmentedControl *_segmentedControl;
    UIPageViewController *_pageViewController;
    NSArray <UIViewController *> *_childTableVCs;
    NSInteger _currentIndex;
    BOOL _callAPISuccess;
    BOOL _viewDisplayed;
    CGFloat _minHeightPageView;
}

#pragma mark - life cycle
- (instancetype)initWithIDPage:(NSInteger)idPage
{
    self = [super init];
    if (self) {
        _idPage = idPage;
        self.model = [[FMPageDetailModel alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    [self setData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self startAnimationLoading];
    [self.model getPageInfoWithIDPage:_idPage];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    _viewDisplayed = YES;
    _minHeightPageView == 0 ? _minHeightPageView = self.contentPageView.frame.size.height + 10 : 0;
    [self setDataListView];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    _segmentedControl.frame = self.contentSegmentView.bounds;
    _pageViewController.view.frame = self.contentPageView.bounds;
}

#pragma mark - private
- (void)setUI {
    self.hideNav = YES;
    self.rateView.layer.cornerRadius = 4;
    self.imgPageInfo.layer.cornerRadius = self.imgPageInfo.frame.size.height/2;
    
    // Gradient image Banner
    {
        CAGradientLayer *gradientMask = [CAGradientLayer layer];
        gradientMask.frame = self.imgBanner.bounds;
        gradientMask.colors = @[(id)[UIColor colorWithRed:0.0 green:0.0 blue:0.34 alpha:0.0].CGColor,
                                (id)[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0].CGColor];
        self.imgBanner.layer.mask = gradientMask;
    }
}

- (void)setData {
    self.model.delegate = self;
    [self setupSegmentControl];
    [self setupPageVC];
}

- (void)startAnimationLoading {
    [CommonFunction showLoadingView];
}

- (void)stopAnimationLoading {
    [CommonFunction hideLoadingView];
}

- (void)binData {
    _callAPISuccess = YES;
    // bin Data label+buton
    [self.imgBanner sd_setImageWithURL:[NSURL URLWithString:_pageInfo.page_view.image]];
    [self.imgPageInfo sd_setImageWithURL:[NSURL URLWithString:_pageInfo.page_view.logo]];
    self.lblName.text = _pageInfo.page_view.name ?:@"";
    self.lblDescription.attributedText = [CommonFunction convertHTMLString:_pageInfo.short_description?:@""];
    self.lblTime.text = [NSString stringWithFormat:@"Mở cửa: %@ - %@", _pageInfo.page_view.open_time?:@"", _pageInfo.page_view.close_time?:@""];
    self.lbRate.text = [NSString stringWithFormat:@"%ld", (long)_pageInfo.page_view.rate_count];
    self.btLike.selected = _pageInfo.page_view.is_bookmark;
    
    //bin Data listView
    [self setDataListView];
}

- (void)setDataListView {
    if(!_callAPISuccess || !_viewDisplayed) {
        return;
    }
    FMListItemIntroduceVC *firstVC = [[FMListItemIntroduceVC alloc] initWithPageInfo:_pageInfo];
    firstVC.changeHeightContentTableView = ^(CGFloat heightContentTableView) {
        [self updateContraintHeightPage:heightContentTableView];
    };
    FMListItemImageVC *secondVC = [[FMListItemImageVC alloc] initWithListImage:_pageInfo.albums];
    secondVC.changeHeightContentTableView = ^(CGFloat heightContentTableView) {
        [self updateContraintHeightPage:heightContentTableView];
    };
    
    FMListItemRateVC *thirdVC = [[FMListItemRateVC alloc] initWithPageInfo:_pageInfo];
    thirdVC.changeHeightContentTableView = ^(CGFloat heightContentTableView) {
        [self updateContraintHeightPage:heightContentTableView];
    };
    
    _childTableVCs = [NSArray arrayWithObjects: firstVC, secondVC, thirdVC, nil];
    [_pageViewController setViewControllers:@[_childTableVCs[_currentIndex]] direction:UIPageViewControllerNavigationDirectionReverse animated:NO completion:nil];
    [_segmentedControl setSelectedSegmentIndex:_currentIndex animated:YES];
}

- (void)updateContraintHeightPage:(CGFloat) heightContentTableView {
    if (_minHeightPageView > heightContentTableView) {
        heightContentTableView = _minHeightPageView;
    }
    [UIView animateWithDuration:0.3 animations:^{
       self.constraintHeightPageView.constant = heightContentTableView;
    }];
}

- (void)setupSegmentControl {
    _segmentedControl = [[HMSegmentedControl alloc] initWithSectionTitles:@[@"Giới thiệu", @"Ảnh & Video", @"Đánh giá"]];
    _segmentedControl.segmentWidthStyle = HMSegmentedControlSegmentWidthStyleFixed;
    _segmentedControl.selectionStyle = HMSegmentedControlSelectionStyleTextWidthStripe;
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
    _pageViewController.dataSource = self;
    _pageViewController.delegate = self;
    _pageViewController.doubleSided = YES;
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

#pragma mark - MVPromotionDetailModelDelegate

- (void)getDataSuccess:(PageInfo *)pageInfo {
    [self stopAnimationLoading];
    _pageInfo = pageInfo;
    [self binData];
}

- (void)getDataError {
    [self stopAnimationLoading];
    [self.view makeToast:@"Có lỗi xẩy ra thử lại sau" duration:4.0 position:CSToastPositionCenter];
}

- (void)getDataFail {
    [self stopAnimationLoading];
    [self.view makeToast:@"Không lấy được dữ liệu" duration:4.0 position:CSToastPositionCenter];
}

#pragma mark - IBAction
- (IBAction)didSelectBackButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)didSelectShareAction:(id)sender {
    NSArray* sharedObjects=[NSArray arrayWithObjects:@"sharecontent",  nil];
    UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:sharedObjects applicationActivities:nil];
    activityViewController.popoverPresentationController.sourceView = self.view;
    [self presentViewController:activityViewController animated:YES completion:nil];
}

- (IBAction)didSelectLikeAction:(id)sender {
    __block FMPageDetailVC *blockSelf = self;
    [appDelegate loginRequiredWithSuccessBlock:^(BOOL isSuccess) {
        if(!isSuccess) {
            return;
        }
        if (self.btLike.selected) {
            [self.model deletePageInterested:blockSelf->_idPage withSuccessBlock:^(BOOL success) {
                if (success) {
                    blockSelf.btLike.selected = !blockSelf.btLike.selected;
                } else {
                    [CommonFunction showToast:kMessageError];
                }
            }];
        } else {
            [self.model addPageInterested:blockSelf->_idPage pageName:blockSelf->_pageInfo.page_view.name withSuccessBlock:^(BOOL success) {
                if (success) {
                    blockSelf.btLike.selected = !blockSelf.btLike.selected;
                } else {
                    [CommonFunction showToast:kMessageError];
                }
            }];
        }
    }];
}

#pragma mark - UIPageViewControllerDataSource
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

#pragma mark - UIPageViewControllerDelegate
- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed{
    if (completed) {
        [_segmentedControl setSelectedSegmentIndex:_currentIndex animated:YES];
    }
}

@end
