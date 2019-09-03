//
//  MVUtilSearchViewController.m
//  FuzzyMark
//
//  Created by Tu Tran on 9/2/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import "MVUtilSearchViewController.h"
#import "MVUtilSearchCell.h"

@interface MVUtilSearchViewController () <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>
@property (strong, nonatomic) UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation MVUtilSearchViewController {
    NSString *_keySearch;
    NSArray *_services;
    NSArray *_filterServices;
}

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navTitle = @"Tiện ích";
    [self initUI];
    [self initData];
}

#pragma mark - private
- (void)initUI {
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 70, 320, 44)];
    _searchBar.placeholder = @"Tìm kiếm trong tiện ích...";
    _searchBar.backgroundImage = [UIImage new];
    _searchBar.backgroundColor = [UIColor whiteColor];
    _searchBar.delegate = self;
    @try {
        UITextField *tfSearch = [_searchBar valueForKey:@"_searchField"];
        [tfSearch setFont:[UIFont fontWithName:@"Muli" size:14.0]];
        [tfSearch setReturnKeyType:UIReturnKeyDone];
    } @catch (NSException *exception) {
        
    }
    
    // Set tableView
    _tableView.tableHeaderView = _searchBar;
    [_tableView registerNib:[UINib nibWithNibName:@"MVUtilSearchCell" bundle:nil] forCellReuseIdentifier:@"cell"];
}

- (void)initData {
    _services = [ConfigApp getListSubServices]?:@[];
}

#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_keySearch.length > 0) {
        return _filterServices.count;
    } else {
        return _services.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MVUtilSearchCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (_keySearch.length > 0) {
        [cell binDataWithService:_filterServices[indexPath.row]];
        return cell;
    } else {
        [cell binDataWithService:_services[indexPath.row]];
        return cell;
    }
}

#pragma mark - UITableViewDatasource
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - UISearchBarDelegate
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    _keySearch = searchText;
    NSPredicate *searchPredicate = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"SELF.name CONTAINS[cd] '%@'", _keySearch]];
    NSArray *arr = [_services filteredArrayUsingPredicate:searchPredicate];
    _filterServices = arr?:@[];
    
    [self.tableView reloadData];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [_searchBar endEditing:YES];
}

@end
