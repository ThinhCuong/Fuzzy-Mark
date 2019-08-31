//
//  FMListItemImageVC.m
//  FuzzyMark
//
//  Created by Tu Tran on 8/30/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import "FMListItemImageVC.h"
#import "FMPageInfoImageCell.h"

@interface FMListItemImageVC ()

@end

@implementation FMListItemImageVC {
    NSArray <AlbumView*> * _albums;
}

#pragma mark - life cycle
- (instancetype)initWithListImage:(NSArray <AlbumView*> *) albums
{
    self = [super init];
    if (self) {
        _albums = albums;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.contentCollectionView registerNib:[UINib nibWithNibName:@"FMPageInfoImageCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return  _albums.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FMPageInfoImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    [cell binDataWithAlbum:_albums[indexPath.row]];
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}



@end
