//
//  FMIntroCameraViewController.m
//  FuzzyMark
//
//  Created by Tu Tran on 5/29/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import "FMIntroCameraViewController.h"
#import "FMIntroCameraCell.h"
#import <CHIPageControl-Swift.h>
@interface FMIntroCameraViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionContent;
@property (weak, nonatomic) IBOutlet CHIPageControlJaloro *pageControll;


@end

@implementation FMIntroCameraViewController {
    NSArray *listImage;
    NSArray *listText;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.collectionContent.delegate = self;
    self.collectionContent.dataSource = self;
    [self.collectionContent registerNib:[UINib nibWithNibName:@"FMIntroCameraCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    listImage = [NSArray arrayWithObjects:@"img_bill_1", @"img_bill_2", @"img_bill_3",nil];
    listText = [NSArray arrayWithObjects:@"Chụp từ mép trên của hoá đơn Căn chỉnh hoá đơn vừa khớp khung hình chụp", @"Trường hợp hoá đơn quá dài, bạn có thể chụp nhiều hình cho đến hết chiều dài hoá đơn.", @"Hình ảnh sau khi chụp xong phải đầy đủ thông tin của hoá đơn. Không bị lệch hay chồng chéo",nil];
}

#pragma mark - UICollectionViewDelegate

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 3;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FMIntroCameraCell *cell = [self.collectionContent dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    [cell billDataWithImage:listImage[indexPath.row] andTitle:listText[indexPath.row]];
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return collectionView.frame.size;
}

#pragma mark - IBAction
- (IBAction)close:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSInteger index = (NSInteger)scrollView.contentOffset.x / (NSInteger)scrollView.frame.size.width;
    [self.pageControll setProgress:index];
}

@end
