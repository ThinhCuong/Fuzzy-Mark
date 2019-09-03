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
@property (strong, nonatomic) FMVouchersObjecRequest *objRequest;
@end

@implementation MVUtilSearchViewController {
    NSString *_keySearch;
    NSArray<WrapService*> *_services;
    NSArray<WrapService*> *_filterServices;
}

#pragma mark - life cycle
- (instancetype)initWith:(FMVouchersObjecRequest *) objRequest {
    self = [super init];
    if (self) {
        _objRequest = objRequest ?: [FMVouchersObjecRequest new];
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navTitle = @"Tiện ích";
    [self addRightButtonNavigationBar];
    [self initUI];
    [self initData];
}

#pragma mark - private
- (void)addRightButtonNavigationBar {
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithTitle:@"Xong" style:UIBarButtonItemStylePlain target:self action:@selector(didSelectRightButton)];
    [rightBarButton setTitleTextAttributes:@{NSFontAttributeName: [UIFont fontWithName:@"Muli" size:14]} forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = rightBarButton;
}

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
    NSMutableArray *listWrap = [NSMutableArray new];
    for (Service *service in [ConfigApp getListSubServices]?:@[]) {
        WrapService *wrap = [WrapService new];
        wrap.service = service;
        if ([_objRequest checkServiceIsExistList:service.idService]) {
            wrap.selected = YES;
        } else {
            wrap.selected = NO;
        }
        [listWrap addObject:wrap];
    }
    _services = listWrap.copy;
}

- (void)didSelectRightButton {
    // Save Data
    for (WrapService *wrap in _services) {
        if (wrap.isSelected) {
            [_objRequest addSeviceID:wrap.service.idService];
        } else  {
            [_objRequest removeSeviceID:wrap.service.idService];
        }
    }
    [self.navigationController popViewControllerAnimated:YES];
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
    WrapService *obj;
    if (_keySearch.length > 0) {
        obj = _filterServices[indexPath.row];
    } else {
        obj = _services[indexPath.row];
    }
    [cell binDataWithService:obj.service];
    [cell selectedCheckBox:obj.isSelected];
    return cell;
}

#pragma mark - UITableViewDatasource
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    WrapService *obj;
    if (_keySearch.length > 0) {
        obj = _filterServices[indexPath.row];
    } else {
        obj = _services[indexPath.row];
    }
    obj.selected = !obj.selected;
    MVUtilSearchCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell selectedCheckBox:obj.isSelected];
}

#pragma mark - UISearchBarDelegate
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    _keySearch = searchText;
    NSPredicate *searchPredicate = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"SELF.service.name CONTAINS[cd] '%@'", _keySearch]];
    NSArray *arr = [_services filteredArrayUsingPredicate:searchPredicate];
    _filterServices = arr?:@[];
    
    [self.tableView reloadData];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [_searchBar endEditing:YES];
}

@end

@implementation WrapService


@end
