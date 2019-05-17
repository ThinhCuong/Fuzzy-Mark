//
//  LocationFavoriteViewController.m
//  FuzzyMark
//
//  Created by Tu Tran on 5/16/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import "FMLocationFavoriteViewController.h"
#import "LocationFavoriteTableViewCell.h"

@interface FMLocationFavoriteViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation FMLocationFavoriteViewController

#pragma mark - life cycle
- (instancetype)init
{
    self = [super init];
    if (self) {
//        self.model = [[FMHistoryPointModel alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBar];
    [self setTableViewContent];
    
//    [self.model.listData removeAllObjects];
//    [self.model getListHistoryCaptureWithSuccessBlock:^(id data) {
//        if(data) {
//            [self reloadData:data];
//        }
//    }];
}

#pragma mark - private
- (void)setTableViewContent {
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 20, 0);
    [self.tableView registerNib:[UINib nibWithNibName:@"LocationFavoriteTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
}

- (void)setNavigationBar {
    self.navigationItem.title = @"Địa điểm quan tâm";
    self.navigationController.navigationBar.topItem.title = @"";
    self.isHideNavigationBar = NO;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ic_filter"] style:UIBarButtonItemStylePlain target:self action:@selector(didSelectRightBarButtonItem)];
}

- (void)didSelectRightBarButtonItem {
    NSLog(@"right barbutton");
}

- (void)reloadData:(id) data {
    if(data) {
//        _listHistoryBill = data;
//        if(_listHistoryBill.count > 0) {
//            [self.tableView reloadData];
//        } else {
//
//        }
    } else {
        
    }
}

#pragma mark - TableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LocationFavoriteTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    return cell;
}

#pragma mark - TableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
