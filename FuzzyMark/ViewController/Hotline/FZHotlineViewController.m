//
//  FZHotlineViewController.m
//  FuzzyMark
//
//  Created by Nguyen Cuong on 6/23/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import "FZHotlineViewController.h"
#import "MVHotlineCollectionViewCell.h"

@interface FZHotlineViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@end

@implementation FZHotlineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.collectionView registerNib:[UINib nibWithNibName:@"MVHotlineCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"MVHotlineCollectionViewCell"];
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 2;
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    MVHotlineCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MVHotlineCollectionViewCell" forIndexPath:indexPath];
   
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGSize cellSize = CGSizeMake((self.collectionView.bounds.size.width - 40) / 2, 220);
    return cellSize;
}

- (IBAction)backAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


@end
