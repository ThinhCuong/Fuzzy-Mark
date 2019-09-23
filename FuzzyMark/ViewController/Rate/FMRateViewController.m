//
//  FMRateViewController.m
//  FuzzyMark
//
//  Created by Tu Tran on 9/8/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import "FMRateViewController.h"
#import "ConfigAppObject.h"
#import "FMRateCommentCell.h"

@interface FMRateViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (assign, nonatomic) RateConfigsFlag flag;
@end

@implementation FMRateViewController {
    BaseCallApi *_httpClient;
    NSArray *_lowArr;
    NSArray *_mediumArr;
    NSArray *_highArr;
    RateConfig *_rateConfigs;
    NSInteger _idPage;
}

#pragma mark - life cycle
- (instancetype)initWithIDPage:(NSInteger) idPage {
    self = [super init];
    if (self) {
        _idPage = idPage;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setUI];
    [self setData];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

#pragma mark - private
- (void)setUI {
    self.navTitle = @"Đánh giá ưu đãi";
    [self addRightButtonNavigationBar];
    [self.collectionView registerNib:[UINib nibWithNibName:@"FMRateCommentCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    [self setupRateView];
    self.textView.placeholder = @"Viết đánh giá của bạn về địa điểm hoặc bạn có thể dùng những đánh giá mà app gợi ý sẵn";
    self.textView.placeholderColor = [UIColor colorWithRed:0.59 green:0.59 blue:0.59 alpha:1.0];
}

- (void)setupRateView {
    [CosmosSettingsObjCBridge setDidTouchCosmos:^(double rate) {
        [self setFlagRateView:rate];
    } cosmosView:self.rateView];
}

- (void)setData {
    _httpClient = [BaseCallApi defaultInitWithBaseURL];
    
    _rateConfigs = [ConfigApp getRateConfig];
    _lowArr =_rateConfigs.low;
    _mediumArr = _rateConfigs.medium;
    _highArr = _rateConfigs.high;
    
    self.rateView.rating = 3;
    [self setFlagRateView:3];
}

- (void)addRightButtonNavigationBar {
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithTitle:@"Gửi" style:UIBarButtonItemStylePlain target:self action:@selector(didSelectSent:)];
    [rightBarButton setTitleTextAttributes:@{NSFontAttributeName: [UIFont fontWithName:@"Muli-Bold" size:14]} forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = rightBarButton;
}

- (void)setFlagRateView:(double) value {
    NSInteger integerValue = (NSInteger) value;
    switch (integerValue) {
        case 1:
        case 2:
            self.flag = RateConfigsFlagLow;
            break;
        case 3:
            self.flag = RateConfigsFlagMedium;
            break;
        case 4:
        case 5:
            self.flag = RateConfigsFlagHigh;
            break;
        default:
            break;
    }
    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDatasource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (_flag == RateConfigsFlagLow) {
        return _lowArr.count;
    } else if (_flag == RateConfigsFlagMedium) {
        return _mediumArr.count;
    } else {
        return _highArr.count;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FMRateCommentCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    if (_flag == RateConfigsFlagLow) {
        [cell binData:_lowArr[indexPath.row]];
    } else if (_flag == RateConfigsFlagMedium) {
        [cell binData:_mediumArr[indexPath.row]];
    } else {
        [cell binData:_highArr[indexPath.row]];
    }
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSString *text;
    if (_flag == RateConfigsFlagLow) {
        text = _lowArr[indexPath.row];
    } else if (_flag == RateConfigsFlagMedium) {
        text = _mediumArr[indexPath.row];
    } else {
        text = _highArr[indexPath.row];
    }
    CGSize textSize = [text sizeWithAttributes:@{NSFontAttributeName: [UIFont fontWithName:@"Muli" size:12]}];
    return CGSizeMake(textSize.width + 40, 32);
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSString *text;
    if (_flag == RateConfigsFlagLow) {
        text = _lowArr[indexPath.row];
    } else if (_flag == RateConfigsFlagMedium) {
        text = _mediumArr[indexPath.row];
    } else {
        text = _highArr[indexPath.row];
    }
    self.textView.text = text;
}

#pragma mark - IBAction
- (IBAction)didSelectSent:(id)sender {
    NSString *idPage = [@(_idPage) stringValue];
    NSString *point = [@(_rateView.rating) stringValue];
    NSString *comment = _textView.text?:@"";
    NSDictionary *params = @{@"id": idPage?:@"",
                             @"point" : point?:@"",
                             @"comment" : comment?:@""
                             };
    
    [CommonFunction showLoadingView];
    [_httpClient postDataWithPath:POST_PAGES_RATE andParam:params isSendToken:YES isShowfailureAlert:YES withSuccessBlock:^(id _Nullable success) {
        [CommonFunction hideLoadingView];
        if ([success isKindOfClass:NSDictionary.class]) {
            if ([success codeForKey:@"error_code"] != 0) {
                [CommonFunction showToast:[success stringForKey:@"message"]];
            } else {
                [CommonFunction showToast:@"Đánh giá thành công cảm ơn bạn đã sử dụng dịch vụ"];
                double delayInSeconds = 3.0;
                dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
                dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                    [self.navigationController popViewControllerAnimated:YES];
                });
            }
        }
    } withFailBlock:^(id _Nullable fail) {
        [CommonFunction hideLoadingView];
        [CommonFunction showToast:kMessageError];
    }];
    
}

@end
