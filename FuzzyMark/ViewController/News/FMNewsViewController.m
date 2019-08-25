//
//  FMNewsViewController.m
//  FuzzyMark
//
//  Created by Tu Tran on 4/17/19.
//  Copyright © 2019 Tu Tran. All rights reserved.
//

#import "FMNewsViewController.h"
#import "FZNewsObject.h"
#import "FMFirstNewsTableViewCell.h"
#import "FMSecondsNewsTableViewCell.h"

@interface FMNewsViewController () <UITableViewDataSource, UITableViewDelegate>

@property(strong, nonatomic) NSArray *listNews;
@property(strong, nonatomic) NSArray *listNewsRemovedFirstItem;
@end

@implementation FMNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.tableView registerNib:[UINib nibWithNibName:@"FMFirstNewsTableViewCell" bundle:nil] forCellReuseIdentifier:@"FMFirstNewsTableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"FMSecondsNewsTableViewCell" bundle:nil] forCellReuseIdentifier:@"FMSecondsNewsTableViewCell"];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.navTitle = @"Tin tức";
    [self callGetNewsApi];
    
}

- (void)callGetNewsApi {
    NSDictionary *params = @{
                             @"limit": @"50",
                             @"offset": @"0"
                             };
    
    [SVProgressHUD setContainerView:self.view];
    [SVProgressHUD show];
    [[BaseCallApi defaultInitWithBaseURL] getDataWithPath:@"news/get-news" andParam:params isShowfailureAlert:YES withSuccessBlock:^(id dataResponse) {
        [SVProgressHUD dismiss];
        [SVProgressHUD setBackgroundLayerColor:UIColor.redColor];
        if (dataResponse) {
            NSInteger errorCode = [dataResponse codeForKey:@"error_code"];
            NSString *message = [dataResponse stringForKey:@"message"];
            self.listNews = [NSArray new];
            self.listNewsRemovedFirstItem = [NSArray new];
            if (errorCode == 0) {
                NSArray *data = [dataResponse arrayForKey:@"data"];
                NSMutableArray *temp = [NSMutableArray new];
                NSMutableArray *tempRemove = [NSMutableArray new];
                for (NSDictionary *dict in data) {
                    FZNewsObject *newsInfo = [[FZNewsObject alloc] initWithDataDictionary:dict];
                    [temp addObject:newsInfo];
                }
                self.listNews = temp.copy;
                tempRemove = temp;
                [tempRemove removeObjectAtIndex:0];
                self.listNewsRemovedFirstItem = tempRemove.copy;
            } else {
                [CommonFunction showToast:message];
            }
            [self.tableView reloadData];
        }
    } withFailBlock:^(id responseError) {
        [SVProgressHUD dismiss];
        [self.tableView reloadData];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else {
        return self.listNewsRemovedFirstItem.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        FMFirstNewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FMFirstNewsTableViewCell"];
        [cell bindData:self.listNews.firstObject];
         return cell;
    } else {
        FMSecondsNewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FMSecondsNewsTableViewCell"];
        [cell bindData:self.listNewsRemovedFirstItem[indexPath.row]];
         return cell;
    }
}

@end
