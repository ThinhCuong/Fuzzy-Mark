//
//  FZNewsInfoDetailViewController.m
//  FuzzyMark
//
//  Created by Nguyen Cuong on 8/25/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import "FZNewsInfoDetailViewController.h"
#import "FZNewsObject.h"
#import "FMFirstNewsTableViewCell.h"
#import "FMNewsCollectionViewCell.h"
#import "FZNewsContentTableViewCell.h"
#import "FMNewsViewTableViewCell.h"

@interface FZNewsInfoDetailViewController () <UITableViewDataSource, UITableViewDelegate, UICollectionViewDelegateFlowLayout>

@property(strong, nonatomic) FZNewsObject *newsInfoDetail;
@property(strong, nonatomic) NSArray *listNewsRelate;
@property(strong, nonatomic) NSString *contentHtml;
@end

@implementation FZNewsInfoDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.tableview registerNib:[UINib nibWithNibName:@"FMFirstNewsTableViewCell" bundle:nil] forCellReuseIdentifier:@"FMFirstNewsTableViewCell"];
    [self.tableview registerNib:[UINib nibWithNibName:@"FZNewsContentTableViewCell" bundle:nil] forCellReuseIdentifier:@"FZNewsContentTableViewCell"];
    [self.tableview registerNib:[UINib nibWithNibName:@"FMNewsViewTableViewCell" bundle:nil] forCellReuseIdentifier:@"FMNewsViewTableViewCell"];
    
    self.tableview.dataSource = self;
    self.tableview.delegate = self;
    self.hideNav = YES;
}

- (void)callNewsFullNews:(NSString *)newsId {
    NSDictionary *params = @{
                             @"id": newsId
                             };
    [CommonFunction showLoadingView];
    [[BaseCallApi defaultInitWithBaseURL] getDataWithPath:GET_NEWS_FULL_NEWS andParam:params isShowfailureAlert:YES withSuccessBlock:^(id responseData) {
        [CommonFunction hideLoadingView];
        if ([responseData isKindOfClass:NSDictionary.class]) {
            if ([responseData codeForKey:@"error_code"] == 0) {
                NSDictionary *data = [responseData dictionaryForKey:@"data"];
                self.newsInfoDetail = [[FZNewsObject alloc] initWithDataDictionary:[data dictionaryForKey:@"news_view"]];
                NSMutableArray *temp = [NSMutableArray new];
                for (NSDictionary *dict in [data arrayForKey:@"news_relate"]) {
                    FZNewsObject *newsInfo = [[FZNewsObject alloc] initWithDataDictionary:dict];
                    [temp addObject:newsInfo];
                }
                self.listNewsRelate = temp.copy;
                self.contentHtml = [data stringForKey:@"content"];
                [self.tableview reloadData];
            } else {
                [CommonFunction showToast:[responseData stringForKey:@"message"]];
            }
        } else {
            [CommonFunction showToast:kMessageError];
        }
    } withFailBlock:^(id responseError) {
        [CommonFunction hideLoadingView];
        [CommonFunction showToast:kMessageError];
    }];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        FMFirstNewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FMFirstNewsTableViewCell"];
        [cell bindData:self.newsInfoDetail isNewsDetail:YES];
        return cell;
    } else if (indexPath.section == 1) {
        FZNewsContentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FZNewsContentTableViewCell"];
        [cell bindData:self.contentHtml title:self.newsInfoDetail.newsDescription];
        return cell;
    } else if (indexPath.section == 2) {
        FMNewsViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FMNewsViewTableViewCell"];
        [cell binDataWithListNewRelate:self.listNewsRelate];
        return cell;
    }
    return [UITableViewCell new];
}

- (IBAction)backAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
