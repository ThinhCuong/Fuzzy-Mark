//
//  FMItemHistoryBillVC.m
//  FuzzyMark
//
//  Created by Tu Tran on 5/6/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import "FMItemHistoryBillVC.h"
#import "FMItemHistoryBillModel.h"
#import "FMHeaderViewCell.h"
#import "FMTableViewCell.h"
#import "FMFooterViewCell.h"

@interface FMItemHistoryBillVC ()
@property (strong, nonatomic) FMItemHistoryBillModel *model;
@end

@implementation FMItemHistoryBillVC {
    NSArray <HistoryBill *> *_listHistoryBill;
}

#pragma mark - life cycle
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.model = [[FMItemHistoryBillModel alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"HistoryBillTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"HistoryBillHeaderCell" bundle:nil] forHeaderFooterViewReuseIdentifier:@"header"];
    [self.tableView registerNib:[UINib nibWithNibName:@"HistoryBillFooterCell" bundle:nil] forHeaderFooterViewReuseIdentifier:@"footer"];
    
    [self.model.listData removeAllObjects];
    [self.model getListHistoryCaptureWithSuccessBlock:^(id data) {
        if(data) {
            [self reloadData:data];
        }
    }];
}

#pragma mark -private
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
    return _listHistoryBill.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FMTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    [cell binData:_listHistoryBill[indexPath.section]];
    return cell;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return 100;
//}

@end
