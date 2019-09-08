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
    [self.rateView removeObserver:self forKeyPath:@"rating"];
}

#pragma mark - private
- (void)setUI {
    self.navTitle = @"Đánh giá ưu đãi";
    [self addRightButtonNavigationBar];
    [self.collectionView registerNib:[UINib nibWithNibName:@"FMRateCommentCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
}

- (void)setData {
    [self.rateView addObserver:self forKeyPath:@"rating" options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:nil];
    _rateConfigs = [ConfigApp getRateConfig];
    _lowArr =_rateConfigs.low;
    _mediumArr = _rateConfigs.medium;
    _highArr = _rateConfigs.high;
}

- (void)addRightButtonNavigationBar {
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithTitle:@"Gửi" style:UIBarButtonItemStylePlain target:self action:@selector(didSelectRightButton)];
    [rightBarButton setTitleTextAttributes:@{NSFontAttributeName: [UIFont fontWithName:@"Muli-Bold" size:14]} forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = rightBarButton;
}

- (void)didSelectRightButton {
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (context == @"rating") {
        CosmosView *rateView = (CosmosView*) object;
        [self setFlagRateView:rateView.rating];
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
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
    NSDictionary *params = @{@"id": idPage,
                             @"point" : point,
                             @"comment" : comment
                                 };
    [_httpClient postDataWithPath:POST_PAGES_RATE andParam:params isShowfailureAlert:YES withSuccessBlock:^(id _Nullable success) {
        
    } withFailBlock:^(id _Nullable fail) {
        
    }];
}

@end
