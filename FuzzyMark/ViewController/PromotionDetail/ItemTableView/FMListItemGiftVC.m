//
//  FMListItemGift.m
//  FuzzyMark
//
//  Created by Tu Tran on 6/20/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import "FMListItemGiftVC.h"
#import "FMPromotionGiftCell.h"

@implementation FMListItemGiftVC {
    FzVourcherInfoObject *_jsonModel;
    NSArray <RewardObject *> *_listData;
}

- (instancetype)initWithVoucherDataJson:(FzVourcherInfoObject *) jsonModel
{
    self = [super init];
    if (self) {
        _jsonModel = jsonModel;
        _listData = jsonModel.relatedVouchers;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.contentTableView registerNib:[UINib nibWithNibName:@"FMPromotionGiftCell" bundle:nil] forCellReuseIdentifier:@"cell"];
}

#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _listData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FMPromotionGiftCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    [cell binData:_listData[indexPath.row]];
    return cell;
}

#pragma mark - UITableViewDataSource
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
