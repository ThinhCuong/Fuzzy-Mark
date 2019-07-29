

#import "FMChoicePictureModel.h"
@interface FMChoicePictureModel() <UINavigationControllerDelegate,UIImagePickerControllerDelegate> {
    UIViewController *_presentVC;
    void(^_selectedImageBlock)(id);
}
@end

@implementation FMChoicePictureModel

- (instancetype)init {
    self = [super init];
    if(self) {
        
    }
    return self;
}

- (void)showOptionsCameraAndLibrary:(UIViewController *)presentVC selectedImage:(nonnull void (^)(id _Nonnull))selectedImageBlock{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Chọn nguồn" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"Camera" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self showCamera];
    }];
    UIAlertAction *galeryAction = [UIAlertAction actionWithTitle:@"Bộ thư viện" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self showPhotoLibrary];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Hủy" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alert addAction:cameraAction];
    [alert addAction:galeryAction];
    [alert addAction:cancelAction];
    if(presentVC != nil) {
        [presentVC presentViewController:alert animated:YES completion:nil];
        _selectedImageBlock = selectedImageBlock;
        _presentVC = presentVC;
    }
    alert.view.tintColor = UIColorFromRGBA(0, 122, 255, 1);
}

- (void)showCamera {
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.allowsEditing = NO;
    imagePicker.navigationBar.barTintColor = UIColorFromRGBA(41, 103, 128, 1);
    imagePicker.navigationBar.titleTextAttributes = @{
                                                      NSFontAttributeName: [UIFont setFontMuliWithSize:16],
                                                      NSForegroundColorAttributeName: [UIColor whiteColor]
                                                      };
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [_presentVC presentViewController:imagePicker animated:YES completion:nil];
    } else {
        [CommonFunction showToast:@"Không thể truy cập camera"];
    }
}

- (void)showPhotoLibrary {
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.allowsEditing = NO;
    imagePicker.navigationBar.barTintColor = UIColorFromRGBA(41, 103, 128, 1);
    imagePicker.navigationBar.titleTextAttributes = @{
                                                      NSFontAttributeName: [UIFont setFontMuliWithSize:16],
                                                      NSForegroundColorAttributeName: [UIColor whiteColor]
                                                      };
    
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [_presentVC presentViewController:imagePicker animated:YES completion:nil];
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    UIImage *chosenImage = info[UIImagePickerControllerOriginalImage];
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0ul);
    dispatch_async(queue, ^{
        UIImage *resizeImage = [self resizeImage:chosenImage];
        dispatch_async(dispatch_get_main_queue(), ^{
            self->_selectedImageBlock?self->_selectedImageBlock(resizeImage):0;
        });
    });
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (UIImage *)resizeImage:(UIImage *)image {
    float actualHeight = image.size.height;
    float actualWidth = image.size.width;
    float maxHeight = 300.0;
    float maxWidth = 400.0;
    float imgRatio = actualWidth/actualHeight;
    float maxRatio = maxWidth/maxHeight;
    float compressionQuality = 0.5;//50 percent compression
    
    if (actualHeight > maxHeight || actualWidth > maxWidth)
    {
        if(imgRatio < maxRatio)
        {
            //adjust width according to maxHeight
            imgRatio = maxHeight / actualHeight;
            actualWidth = imgRatio * actualWidth;
            actualHeight = maxHeight;
        }
        else if(imgRatio > maxRatio)
        {
            //adjust height according to maxWidth
            imgRatio = maxWidth / actualWidth;
            actualHeight = imgRatio * actualHeight;
            actualWidth = maxWidth;
        }
        else
        {
            actualHeight = maxHeight;
            actualWidth = maxWidth;
        }
    }
    
    CGRect rect = CGRectMake(0.0, 0.0, actualWidth, actualHeight);
    UIGraphicsBeginImageContext(rect.size);
    [image drawInRect:rect];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    NSData *imageData = UIImageJPEGRepresentation(img, compressionQuality);
    UIGraphicsEndImageContext();
    
    return [UIImage imageWithData:imageData];
    
}
@end
