//
//  MVUtilSearchViewController.m
//  FuzzyMark
//
//  Created by Tu Tran on 9/2/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import "MVUtilSearchViewController.h"
#import "MVUtilSearchCell.h"

@interface MVUtilSearchViewController () <UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating>
@property (strong, nonatomic) UISearchController *searchController;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation MVUtilSearchViewController {
    NSArray *_services;
    NSArray *_filterServices;
}

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initUI];
    [self initData];
}

#pragma mark - private
- (void)setNavigationBar {
    self.navTitle = @"Tiện ích";
}

- (void)initUI {
    // init SearchController
    _searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    _searchController.obscuresBackgroundDuringPresentation = NO;
    _searchController.dimsBackgroundDuringPresentation = NO;
    _searchController.hidesNavigationBarDuringPresentation = NO;
    _searchController.searchResultsUpdater = self;
    
    // set SearchBar
    [_searchController.searchBar sizeToFit];
    _searchController.searchBar.placeholder = @"Tìm kiếm trong tiện ích...";
    _searchController.searchBar.backgroundImage = [UIImage new];
    _searchController.searchBar.backgroundColor = [UIColor whiteColor];
    UITextField *tfSearch = [_searchController.searchBar valueForKey:@"_searchField"];
    [tfSearch setFont:[UIFont fontWithName:@"Muli" size:14.0]];
    
    // Set tableView
    _tableView.tableHeaderView = _searchController.searchBar;
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
    if (_searchController.isActive) {
        return _filterServices.count;
    } else {
        return _services.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MVUtilSearchCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (_searchController.isActive) {
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

#pragma mark - UISearchResultsUpdating
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    NSPredicate *searchPredicate = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"SELF.name CONTAINS[c] '%@'", searchController.searchBar.text]];
    NSArray *arr = [_services filteredArrayUsingPredicate:searchPredicate];
    _filterServices = arr?:@[];
    
    [self.tableView reloadData];
}

@end
