//
//  FMHistoryPointViewController.m
//  FuzzyMark
//
//  Created by Tu Tran on 5/16/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import "FMHistoryPointViewController.h"
#import "FMHistoryPointModel.h"
#import "HistoryPointTableViewCell.h"
#import "HistoryPointHeaderTableViewCell.h"

@interface FMHistoryPointViewController () <UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) FMHistoryPointModel *model;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation FMHistoryPointViewController {
    NSArray *_listHistoryBill;
}

#pragma mark - life cycle
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.model = [[FMHistoryPointModel alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBar];
    [self setTableViewContent];
    
    [self.model.listData removeAllObjects];
    [self.model getListHistoryCaptureWithSuccessBlock:^(id data) {
        if(data) {
            [self reloadData:data];
        }
    }];
}

#pragma mark - private
- (void)setTableViewContent {
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"HistoryPointTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"HistoryPointHeaderTableViewCell" bundle:nil] forCellReuseIdentifier:@"headerCell"];
}

- (void)setNavigationBar {
    self.navigationItem.title = @"Lịch sử nhận điểm thưởng";
    self.navigationController.navigationBar.topItem.title = @"";
    self.isHideNavigationBar = NO;
}

- (void)reloadData:(id) data {
    if(data) {
        _listHistoryBill = data;
        if(_listHistoryBill.count > 0) {
            [self.tableView reloadData];
        } else {
            
        }
    } else {
        
    }
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row == 0) {
        HistoryPointHeaderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"headerCell"];
        return cell;
    } else {
        HistoryPointTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        return cell;
    }
}



@end
