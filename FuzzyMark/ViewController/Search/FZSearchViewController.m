//
//  FZSearchViewController.m
//  FuzzyMark
//
//  Created by Nguyen Cuong on 5/27/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import "FZSearchViewController.h"
#import "FZSearchModel.h"
#import "FZItemSearchCollectionViewCell.h"
#import "FZTitleHeaderCollectionReusableView.h"
#import "FZHeaderSearchTableViewCell.h"
#import "FZFooterCollectionReusableView.h"
#import "FMPromotionDetailVC.h"

@interface FZSearchViewController () <UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout> {
    NSInteger _selectedIndex;
    NSInteger _willSectionIndex;
    NSInteger _didSectionIndex;
    BOOL _isWillIndexEqualDidIndex;
    BOOL _isWill;
}

@property(nonatomic) NSArray<GroupObject *> *listGroup;
@property(nonatomic) NSArray<GroupObject *> *listCategory;

@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) CGFloat lastContentOffset;

@end

@implementation FZSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isHideNavigationBar = YES;
    
    // header
    [self.tableView registerNib:[UINib nibWithNibName:@"FZHeaderSearchTableViewCell" bundle:nil] forCellReuseIdentifier:@"FZHeaderSearchTableViewCell"];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    // collection view
    [self.collectionView registerNib:[UINib nibWithNibName:@"FZTitleHeaderCollectionReusableView" bundle:nil]
          forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                 withReuseIdentifier:@"FZTitleHeaderCollectionReusableView"];
    [self.collectionView registerNib:[UINib nibWithNibName:@"FZFooterCollectionReusableView" bundle:nil]
          forSupplementaryViewOfKind:UICollectionElementKindSectionFooter
                 withReuseIdentifier:@"FZFooterCollectionReusableView"];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"FZItemSearchCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"FZItemSearchCollectionViewCell"];
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    [self callGroupsApi];
    
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.collectionView.contentInset = UIEdgeInsetsMake(0, 0, self.collectionView.contentSize.height / 2.3, 0);
    self.collectionView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 180, 0);
}
- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FZHeaderSearchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FZHeaderSearchTableViewCell"];
    [cell bindData:self.listGroup];
    cell.sectionIndex = _selectedIndex;
    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return _listGroup.count;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.listGroup[section].categories.count;
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    FZItemSearchCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FZItemSearchCollectionViewCell" forIndexPath:indexPath];
    [cell bindData:self.listGroup[indexPath.section].categories[indexPath.row]];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if(kind == UICollectionElementKindSectionHeader)
    {
        FZTitleHeaderCollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind: UICollectionElementKindSectionHeader withReuseIdentifier:@"FZTitleHeaderCollectionReusableView" forIndexPath:indexPath];
        [headerView bindData:self.listGroup[indexPath.section].title];
        return headerView;
    } else {
        FZFooterCollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind: UICollectionElementKindSectionFooter withReuseIdentifier:@"FZFooterCollectionReusableView" forIndexPath:indexPath];
        return headerView;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    CGSize cellSize = CGSizeMake(self.collectionView.bounds.size.width , 50);
    return cellSize;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    CGSize cellSize = CGSizeMake(self.collectionView.bounds.size.width , 5);
    return cellSize;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGSize cellSize = CGSizeMake(self.collectionView.bounds.size.width / 5 , 108);
    return cellSize;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    FMPromotionDetailVC *vc = [[FMPromotionDetailVC alloc] initWithIDVoucher:@"123"];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (self.lastContentOffset > scrollView.contentOffset.y) {
        _selectedIndex = _willSectionIndex;
        [self.tableView reloadData];
        NSLog(@"Scrolling Up");
    } else if (self.lastContentOffset < scrollView.contentOffset.y) {
        if (_willSectionIndex > _didSectionIndex) {
            _selectedIndex = _didSectionIndex;
            [self.tableView reloadData];
        }
        NSLog(@"Scrolling Down");
    }
    
    self.lastContentOffset = scrollView.contentOffset.y;
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingSupplementaryView:(UICollectionReusableView *)view forElementOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath {
    _didSectionIndex = indexPath.section;;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplaySupplementaryView:(UICollectionReusableView *)view forElementKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath {
    _willSectionIndex = indexPath.section;
}

- (void)callGroupsApi {
    
    NSDictionary *params = @{
                             @"token": @"abd",
                             };
    [SVProgressHUD setContainerView:self.view];
    [SVProgressHUD show];
    [[BaseCallApi defaultInitWithBaseURL] getDataWithPath:@"groups" andParam:params isShowfailureAlert:YES withSuccessBlock:^(id responseData) {
        [SVProgressHUD dismiss];
        if (responseData) {
            FZSearchModel *homeData = [[FZSearchModel alloc] initWithDictionary:responseData error:nil];
            self.listGroup = homeData.data;
            [self.collectionView reloadData];
            [self.tableView reloadData];
        }
    } withFailBlock:^(id responseError) {
        [SVProgressHUD dismiss];
    }];
}

@end
