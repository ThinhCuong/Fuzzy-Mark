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

@interface FZSearchViewController () <UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property(nonatomic) NSArray<GroupObject *> *listGroup;
@property(nonatomic) NSArray<GroupObject *> *listCategory;

@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

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
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"FZItemSearchCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"FZItemSearchCollectionViewCell"];
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    [self callGroupsApi];
}


- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FZHeaderSearchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FZHeaderSearchTableViewCell"];
    [cell bindData:self.listGroup];
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
    FZTitleHeaderCollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind: UICollectionElementKindSectionHeader withReuseIdentifier:@"FZTitleHeaderCollectionReusableView" forIndexPath:indexPath];
    [headerView bindData:self.listGroup[indexPath.section].title];
    return headerView;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    CGSize cellSize = CGSizeMake(self.collectionView.bounds.size.width , 50);
    return cellSize;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGSize cellSize = CGSizeMake(self.collectionView.bounds.size.width / 5 , 108);
    return cellSize;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSArray *indexPaths = [self.collectionView indexPathsForVisibleItems];
   // NSIndexPath *middleIndexPath = [indexPaths objectAtIndex:([indexPaths count] / [indexPaths count])];//you must check if indexPaths >=2 or <2
     // NSLog(@"Section :%ld",(long)middleIndexPath.section);
    
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingSupplementaryView:(UICollectionReusableView *)view forElementOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath {
      NSLog(@"Section :%ld",(long)indexPath.section);
}

- (void)collectionView:(UICollectionView *)collectionView willDisplaySupplementaryView:(UICollectionReusableView *)view forElementKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath {
     NSLog(@"will section :%ld",(long)indexPath.section);
}
- (void)callGroupsApi {
    
    NSDictionary *params = @{
                             @"token": @"abd",
                             };
    
    [[BaseCallApi defaultInitWithBaseURL] getDataWithPath:@"groups" andParam:params isShowfailureAlert:YES withSuccessBlock:^(id responseData) {
        if (responseData) {
            FZSearchModel *homeData = [[FZSearchModel alloc] initWithDictionary:responseData error:nil];
            self.listGroup = homeData.data;
            [self.collectionView reloadData];
            [self.tableView reloadData];
        }
    } withFailBlock:^(id responseError) {
        
    }];
}

@end
