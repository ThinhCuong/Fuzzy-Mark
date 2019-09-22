//
//  FZSearchViewController.m
//  FuzzyMark
//
//  Created by Nguyen Cuong on 5/27/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import "FZSearchViewController.h"
#import "FZItemSearchCollectionViewCell.h"
#import "FZTitleHeaderCollectionReusableView.h"
#import "FZHeaderSearchTableViewCell.h"
#import "FZFooterCollectionReusableView.h"
#import "FMVouchersObjecRequest.h"
#import "FZVourchersSearchViewController.h"

@interface FZSearchViewController () <UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, FZHeaderSearchTableViewCellDelegate, UISearchBarDelegate> {
    NSInteger _selectedIndex;
    NSInteger _willSectionIndex;
    NSInteger _didSectionIndex;
    BOOL _isWillIndexEqualDidIndex;
    BOOL _isWill;
}

@property(nonatomic) NSArray<Group *> *listGroup;
@property(nonatomic) NSArray<Group *> *listFilterGroup;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (nonatomic) CGFloat lastContentOffset;

@end

@implementation FZSearchViewController  {
    NSString *_keySearch;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.hideNav = YES;
    
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
    
    @try {
        UITextField *tfSearch = [_searchBar valueForKey:@"_searchField"];
        [tfSearch setFont:[UIFont fontWithName:@"Muli-Light" size:12.0]];
        [tfSearch setReturnKeyType:UIReturnKeyDone];
    }
    @catch (NSException * e) {
    }
    
    self.searchBar.delegate = self;
    
    [self getDataModel];
    
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
    cell.delegate = self;
    if (_keySearch.length > 0) {
        [cell bindData:self.listFilterGroup];
    } else {
        [cell bindData:self.listGroup];
    }
    cell.sectionIndex = _selectedIndex;
    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    if (_keySearch.length > 0) {
        return _listFilterGroup.count;
    } else {
        return _listGroup.count;
    }
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (_keySearch.length > 0) {
        return self.listFilterGroup[section].categories.count;
    } else {
        return self.listGroup[section].categories.count;
    }
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    FZItemSearchCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FZItemSearchCollectionViewCell" forIndexPath:indexPath];
    if (_keySearch.length > 0) {
        [cell bindData:self.listFilterGroup[indexPath.section].categories[indexPath.row]];
    } else {
        [cell bindData:self.listGroup[indexPath.section].categories[indexPath.row]];
    }
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if(kind == UICollectionElementKindSectionHeader)
    {
        FZTitleHeaderCollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind: UICollectionElementKindSectionHeader withReuseIdentifier:@"FZTitleHeaderCollectionReusableView" forIndexPath:indexPath];
        if (_keySearch.length > 0) {
            [headerView bindData:self.listFilterGroup[indexPath.section].title];
        } else {
            [headerView bindData:self.listGroup[indexPath.section].title];
        }
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
    Group *group;
    Category *category;
    if (_keySearch.length > 0) {
        group = _listFilterGroup[indexPath.section];
    } else {
        group = _listGroup[indexPath.section];
    }
    category = group.categories[indexPath.row];
    FMVouchersObjecRequest *obj = [[FMVouchersObjecRequest alloc] init];
    [obj addGroupsID:group.idGroup];
    [obj addCategoryID:category.idCategory];
    FZVourchersSearchViewController *vc = [[FZVourchersSearchViewController alloc] initWithObjectRequest:obj];
    vc.placeholderSearchBar = group.title;
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

- (void)getDataModel {
    self.listGroup = [ConfigApp getListGroups];
    [self.tableView reloadData];
}

#pragma mark - FZHeaderSearchTableViewCellDelegate
- (void)didSelectItemCollectionViewAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - UISearchBarDelegate
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    _keySearch = searchText;
    NSPredicate *searchGroupPredicate = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"SELF.title CONTAINS[cd] '%@'", _keySearch]];
    NSPredicate *searchCategoriesPredicate = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"SELF.name CONTAINS[cd] '%@'", _keySearch]];
    NSMutableArray *array = [NSMutableArray new];
    for (Group *group in _listGroup) {
        
        if ([searchGroupPredicate evaluateWithObject:group]) {
            [array addObject:group];
        } else {
            NSArray *listCategories = [group.categories filteredArrayUsingPredicate:searchCategoriesPredicate];
            if (listCategories.count > 0) {
                Group *groupCopy = [group copy];
                groupCopy.categories = listCategories;
                [array addObject:groupCopy];
            }
        }
    }
    _listFilterGroup = array?:@[];
    [self.tableView reloadData];
    [self.collectionView reloadData];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar endEditing:YES];
}


@end
