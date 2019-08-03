//
//  FMListItemIntroduceVC.m
//  FuzzyMark
//
//  Created by Tu Tran on 6/20/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import "FMListItemIntroduceVC.h"
#import "FMPromotionIntroCell.h"

@implementation FMListItemIntroduceVC {
    FzVourcherInfoObject *_jsonModel;
    NSArray <Page *> *_listData;
}

- (instancetype)initWithVoucherDataJson:(FzVourcherInfoObject *) jsonModel
{
    self = [super init];
    if (self) {
        _jsonModel = jsonModel;
        _listData = jsonModel.acceptedPage;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.contentTableView registerNib:[UINib nibWithNibName:@"FMPromotionIntroCell" bundle:nil] forCellReuseIdentifier:@"cell"];
}

#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _listData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FMPromotionIntroCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    [cell binData:_listData[indexPath.row]];
    return cell;
}

#pragma mark - UITableViewDataSource
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
