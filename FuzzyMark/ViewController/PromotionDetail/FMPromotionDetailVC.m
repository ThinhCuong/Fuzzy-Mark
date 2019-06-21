//
//  MVPromotionDetailVC.m
//  FuzzyMark
//
//  Created by Tu Tran on 6/16/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import "FMPromotionDetailVC.h"
#import "FMPromotionDetailModel.h"
#import "FMCameraViewController.h"
#import <HMSegmentedControl/HMSegmentedControl.h>
#import "FMListItemLocationVC.h"
#import "FMListItemIntroduceVC.h"
#import "FMListItemGiftVC.h"


@interface FMPromotionDetailVC () <FMPromotionDetailModelDelegate, UIPageViewControllerDataSource, UIPageViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imgBanner;
@property (weak, nonatomic) IBOutlet UIImageView *imgVoucher;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblTime;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UIButton *btnSale;
@property (weak, nonatomic) IBOutlet UILabel *lblSale;
@property (weak, nonatomic) IBOutlet UILabel *lblDesc;
@property (weak, nonatomic) IBOutlet UIView *contentSegmentView;
@property (weak, nonatomic) IBOutlet UIView *contentPageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintHeightPageView;

@property (strong, nonatomic) FMPromotionDetailModel *model;

@end

@implementation FMPromotionDetailVC {
    NSString *_idVoucher;
    VoucherInfoJsonModel *_voucherInfo;
    HMSegmentedControl *_segmentedControl;
    UIPageViewController *_pageViewController;
    NSArray <UIViewController *> *_childTableVCs;
    NSInteger _currentIndex;
    NSTimer *_timer;
}

#pragma mark - life cycle
- (instancetype)initWithIDVoucher:(NSString *) idVoucher
{
    self = [super init];
    if (self) {
        _idVoucher = idVoucher;
        self.model = [[FMPromotionDetailModel alloc] init];
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
    [self.model getVouchersInfoWithIDVoucher:_idVoucher];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    _segmentedControl.frame = self.contentSegmentView.bounds;
    _pageViewController.view.frame = self.contentPageView.bounds;
}

#pragma mark - private
- (void)setUI {
    [SVProgressHUD setContainerView:self.view];
    self.isHideNavigationBar = YES;
    self.btnSale.layer.cornerRadius = self.btnSale.frame.size.height / 2;
}

- (void)setData {
    self.model.delegate = self;
    [self setupSegmentControl];
    [self setupPageVC];
}

- (void)startAnimationLoading {
    [SVProgressHUD show];
}

- (void)stopAnimationLoading {
    [SVProgressHUD dismiss];
}

- (void)binData {
    // bin Data label+buton
    [self.imgBanner sd_setImageWithURL:[NSURL URLWithString:_voucherInfo.voucher.image]];
    [self.imgVoucher sd_setImageWithURL:[NSURL URLWithString:_voucherInfo.voucher.logo]];
    self.lblName.text = _voucherInfo.voucher.name ?: @"";
    self.lblSale.text = [NSString stringWithFormat:@"Hoàn tiền %@%ld", @"%", (long)_voucherInfo.voucher.percent_discount] ?: @"";
    [self.btnSale setTitle:[NSString stringWithFormat:@"-%ld%@", (long)_voucherInfo.voucher.percent_discount, @"%"] forState:UIControlStateNormal];
    self.lblDesc.text = _voucherInfo.voucher.descriptionVoucher ?: @"";
    self.lblTitle.text = [NSString stringWithFormat:@"Hiện đã có %ld người sử dụng voucher này", (long)_voucherInfo.count_received];
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateLabelWithCountdownTime) userInfo:nil repeats: YES];
    
    //bin Data listView
    [self setDataListView];
}

- (void)setDataListView {
    FMListItemLocationVC *firstVC = [[FMListItemLocationVC alloc] initWithVoucherDataJson:_voucherInfo];
    firstVC.changeHeightContentTableView = ^(CGFloat heightContentTableView) {
        [self updateContraintHeightPage:heightContentTableView];
    };
    FMListItemIntroduceVC *secondVC = [[FMListItemIntroduceVC alloc] initWithVoucherDataJson:_voucherInfo];
    secondVC.changeHeightContentTableView = ^(CGFloat heightContentTableView) {
        [self updateContraintHeightPage:heightContentTableView];
    };
    FMListItemGiftVC *thirdVC = [[FMListItemGiftVC alloc] initWithVoucherDataJson:_voucherInfo];
    thirdVC.changeHeightContentTableView = ^(CGFloat heightContentTableView) {
        [self updateContraintHeightPage:heightContentTableView];
    };
    _childTableVCs = [NSArray arrayWithObjects: firstVC, secondVC, thirdVC, nil];
    [_pageViewController setViewControllers:@[_childTableVCs[0]] direction:UIPageViewControllerNavigationDirectionReverse animated:NO completion:nil];
}

- (void)updateContraintHeightPage:(CGFloat) heightContentTableView {
    self.constraintHeightPageView.constant = heightContentTableView;
}

- (void)updateLabelWithCountdownTime {
    self.lblTime.text = [self getTimeFormatted:_voucherInfo.voucher.count_down];
}

- (NSString *)getTimeFormatted:(NSInteger) totalSeconds {
    if(totalSeconds == 0) {
        if([_timer isValid]) {
            [_timer invalidate];
        }
        _timer = nil;
    }
    _voucherInfo.voucher.count_down--;
    
    NSInteger day = totalSeconds / 86400;
    NSInteger hours = (totalSeconds % 86400) /3600;
    NSInteger minutes = (totalSeconds % 3600) / 60;
    NSInteger seconds = (totalSeconds % 3600) % 60;
    
    if (day > 0) {
        return [NSString stringWithFormat:@"Còn %02ld ngày : %02ld giờ : %02ld phút : %02ld giây", (long)day, (long)hours, (long)minutes, (long)seconds];
    }
    
    if (hours > 0) {
        return [NSString stringWithFormat:@"Còn %02ld giờ : %02ld phút : %02ld giây", (long)hours, (long)minutes, (long)seconds];
    }
    
    if (minutes > 0) {
         return [NSString stringWithFormat:@"Còn %02ld phút : %02ld giây", (long)minutes, (long)seconds];
    }
    
    return [NSString stringWithFormat:@"Còn %02ld giây", (long)seconds];
    
}

- (void)setupSegmentControl {
    _segmentedControl = [[HMSegmentedControl alloc] initWithSectionTitles:@[@"Địa điểm áp dụng", @"Giới thiệu", @"Thêm quà"]];
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
- (void)getDataSuccess:(VoucherInfoJsonModel *) voucherInfo {
    [self stopAnimationLoading];
    _voucherInfo = voucherInfo;
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

- (IBAction)didSelectTakePhoto:(id)sender {
    FMCameraViewController *vc = [[FMCameraViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
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
