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

@interface FZNewsInfoDetailViewController () <UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

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
    
    self.tableview.dataSource = self;
    self.tableview.delegate = self;
    self.hideNav = YES;
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"FMNewsCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"FMNewsCollectionViewCell"];
        
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
}

- (void)callNewsFullNews:(NSString *)newsId {
    NSDictionary *params = @{
                             @"id": newsId,
                             };
    
    [SVProgressHUD setContainerView:self.view];
    [SVProgressHUD show];
    [[BaseCallApi defaultInitWithBaseURL] getDataWithPath:@"news/full-news" andParam:params isShowfailureAlert:YES withSuccessBlock:^(id dataResponse) {
        [SVProgressHUD dismiss];
        [SVProgressHUD setBackgroundLayerColor:UIColor.redColor];
        if (dataResponse) {
            NSInteger errorCode = [dataResponse codeForKey:@"error_code"];
            NSString *message = [dataResponse stringForKey:@"message"];
            
            if (errorCode == 0) {
                NSDictionary *data = [dataResponse dictionaryForKey:@"data"];
                self.newsInfoDetail = [[FZNewsObject alloc] initWithDataDictionary:[data dictionaryForKey:@"news_view"]];
                NSMutableArray *temp = [NSMutableArray new];
                for (NSDictionary *dict in [data arrayForKey:@"news_relate"]) {
                    FZNewsObject *newsInfo = [[FZNewsObject alloc] initWithDataDictionary:dict];
                    [temp addObject:newsInfo];
                }
                self.listNewsRelate = temp.copy;
                self.contentHtml = [data stringForKey:@"content"];
            } else {
                [CommonFunction showToast:message];
            }
            [self.tableview reloadData];
            [self.collectionView reloadData];
        }
    } withFailBlock:^(id responseError) {
        [SVProgressHUD dismiss];
        [self.tableview reloadData];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
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
    } else {
        FZNewsContentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FZNewsContentTableViewCell"];
        [cell bindData:self.contentHtml];
        return cell;
    }
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.listNewsRelate.count;
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    FMNewsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FMNewsCollectionViewCell" forIndexPath:indexPath];
    [cell bindData:self.listNewsRelate[indexPath.row]];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGSize cellSize = CGSizeMake((collectionView.bounds.size.width - 50) / 2, 130);
    return cellSize;
}

- (IBAction)backAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
