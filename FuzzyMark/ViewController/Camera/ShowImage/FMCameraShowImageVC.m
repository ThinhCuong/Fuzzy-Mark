//
//  FMCameraShowImage.m
//  FuzzyMark
//
//  Created by Tu Tran on 5/29/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import "FMCameraShowImageVC.h"
#import "CameraShowImageCell.h"
#import "FMSendImageVoucherSuccessVC.h"

@interface FMCameraShowImageVC () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionViewContent;

@end

@implementation FMCameraShowImageVC {
    NSInteger _voucherID;
}

#pragma mark - life cycle
- (instancetype)initWithVoucherID:(NSInteger) voucher_id {
    self = [super init];
    if (self) {
        _voucherID = voucher_id;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionViewContent.delegate = self;
    self.collectionViewContent.dataSource = self;
    [self.collectionViewContent registerNib:[UINib nibWithNibName:@"CameraShowImageCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.collectionViewContent reloadData];
    if(_listImage.count > 1) {
        CGFloat x = self.collectionViewContent.contentSize.width - self.collectionViewContent.frame.size.width / 2;
        [self.collectionViewContent setContentOffset:CGPointMake(x, 0)];
    } else {
        [self.collectionViewContent setContentOffset:CGPointMake(0, 0)];
    }
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.listImage.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CameraShowImageCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    NSString *index = [NSString stringWithFormat:@"%ld/%lu", (long)(indexPath.row+1), (unsigned long)self.listImage.count];
    [cell binDataIndex:index withImage:self.listImage[indexPath.row]];
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return collectionView.frame.size;
}

#pragma mark - IBAction
- (IBAction)didSelectNewTakePhoto:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)didSelectReTakePhoto:(id)sender {
    [self.listImage removeAllObjects];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)didSelectUpload:(id)sender {
    NSDictionary *param = @{@"voucher_id": @1};
    BaseCallApi *httpClient = [BaseCallApi defaultInitWithBaseURL];
    [CommonFunction showLoadingView];
    [httpClient postDataWithPath:POST_USER_UPLOAD_BILLS queriesParam:param bodyParam:@{} constructingBodyWithBlock:^(id<AFMultipartFormData> _Nonnull formData) {
        int i = 0;
        for (UIImage *img in self->_listImage) {
            i++;
            if (i > 3) {
                return;
            }
            NSData *data = UIImageJPEGRepresentation(img, 0.5);
            [formData appendPartWithFileData:data
                                        name:@"bills"
                                    fileName:[NSString stringWithFormat:@"image%d.jpg",i]
                                    mimeType:@"image/jpeg"];
        }
    } isSendToken:YES isShowfailureAlert:YES withSuccessBlock:^(id responseObject) {
        [CommonFunction hideLoadingView];
        if ([responseObject isKindOfClass:NSDictionary.class]) {
            if ([responseObject codeForKey:@"error_code"] != 0) {
                [CommonFunction showToast:[responseObject stringForKey:@"message"]];
            } else {
                FMSendImageVoucherSuccessVC *vc = [[FMSendImageVoucherSuccessVC alloc] init];
                [self presentViewController:vc animated:YES completion:nil];
            }
        }
    } withFailBlock:^(id failObject) {
        [CommonFunction hideLoadingView];
        [CommonFunction showToast:@"Không gửi được ảnh. Vui lòng thử lại sau"];
    }];
}

- (IBAction)didSelectBack:(id)sender {
    [self.listImage removeAllObjects];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
