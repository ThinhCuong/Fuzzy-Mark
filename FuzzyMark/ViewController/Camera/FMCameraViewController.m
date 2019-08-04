//
//  FMCameraViewController.m
//  FuzzyMark
//
//  Created by Tu Tran on 5/3/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import "FMCameraViewController.h"
#import "FMIntroCameraViewController.h"

@interface FMCameraViewController () <AVCapturePhotoCaptureDelegate>
@property (weak, nonatomic) IBOutlet UIView *previewView;
@property (weak, nonatomic) IBOutlet UIView *blurView;
@property (weak, nonatomic) IBOutlet UIView *middleView;
@property (weak, nonatomic) IBOutlet UIView *introView;


@property (strong, nonatomic) AVCaptureSession *session;
@property (strong, nonatomic) AVCapturePhotoOutput *stillImageOutput;
@property (strong, nonatomic) AVCaptureVideoPreviewLayer *videoPreviewLayer;
@end

@implementation FMCameraViewController {
    NSMutableArray *_listImage;
    BOOL _firstLoad;
}

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _firstLoad = YES;
    [self.introView setAlpha:0.0];
    self.hideNav = YES;
    _listImage = [[NSMutableArray alloc] init];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    // Setup your camera here...
    if(_firstLoad) {
        [self setBlurView];
        _firstLoad = NO;
    }
    [self checkPermissionsCamera];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.session stopRunning];
}

- (void)setBlurView {
    UIBezierPath *transparentPath = [UIBezierPath bezierPathWithRect:self.middleView.frame];
    UIBezierPath *overlayPath = [UIBezierPath bezierPathWithRect:self.previewView.frame];
    [overlayPath appendPath:transparentPath];
    [overlayPath setUsesEvenOddFillRule:YES];
    
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = overlayPath.CGPath;
    maskLayer.fillRule = kCAFillRuleEvenOdd;
    maskLayer.fillColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.54].CGColor;
    [self.blurView.layer addSublayer:maskLayer];
    
    [UIView animateWithDuration:0.3 animations:^{
        [self.introView setAlpha:1.0];
    }];
}

- (void)checkPermissionsCamera {
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    switch (authStatus) {
        case AVAuthorizationStatusAuthorized: {
            if(!self.session) {
                [self greateNewSession];
            } else {
                [self.session startRunning];
            }
            break;
        }
        case AVAuthorizationStatusDenied:
        case AVAuthorizationStatusRestricted: {
            NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
            if ([[UIApplication sharedApplication] canOpenURL:url]) {
                
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle: @"Bạn cần cho phép FuzzyMark truy cập Camera để thực hiện chức năng này" message: @"Chuyển tới: Settings > Privacy > Camera để bật"  preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction *OKAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
                }];
                UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"Cancle" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [self popViewControllerAfterWithTime:0.0];
                }];
                [alertController addAction:OKAction];
                [alertController addAction:cancleAction];
                
                [self presentViewController:alertController animated:YES completion:nil];
            break;
            }
        }
        case AVAuthorizationStatusNotDetermined: {
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                if(granted) {
                    [self greateNewSession];
                } else {
                    [self popViewControllerAfterWithTime:0.0];
                }
            }];
            break;
        }
        default:
            break;
    }
}

- (void)greateNewSession {
    self.session = [AVCaptureSession new];
    self.session.sessionPreset = AVCaptureSessionPresetPhoto;
    AVCaptureDevice *backCamera = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if(!backCamera) {
        NSLog(@"Thiet bi khong co Camera");
        [self.view makeToast:@"Không tìm thấy Camera trên thiết bị" duration:4.0 position:CSToastPositionCenter];
        [self popViewControllerAfterWithTime:2.0];
        return;
    }
    NSError *error;
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:backCamera error:&error];
    if(!error) {
        self.stillImageOutput = [AVCapturePhotoOutput new];
        if([self.session canAddInput:input] && [self.session canAddOutput:self.stillImageOutput]) {
            [self.session addInput:input];
            [self.session addOutput:self.stillImageOutput];
            [self setupLivePreview];
        }
    } else {
        NSLog(@"Xẩy ra lỗi: %@", error.localizedDescription);
        [self.view makeToast:@"Rất tiếc. Có sự cố không mong muốn xẩy ra" duration:4.0 position:CSToastPositionCenter];
        [self popViewControllerAfterWithTime:2.0];
    }
}

- (void)popViewControllerAfterWithTime:(double) seconds {
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(seconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self.navigationController popViewControllerAnimated:YES];
    });
}

- (void)setupLivePreview {
    self.videoPreviewLayer = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
    if(self.videoPreviewLayer) {
        
        self.videoPreviewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
        self.videoPreviewLayer.connection.videoOrientation = AVCaptureVideoOrientationPortrait;
        [self.previewView.layer addSublayer:self.videoPreviewLayer];
        
        dispatch_queue_t globalQueue =  dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
        dispatch_async(globalQueue, ^{
            [self.session startRunning];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                self.videoPreviewLayer.frame = self.previewView.bounds;
            });
            
        });
    }
}

#pragma mark IBAction

- (IBAction)didSelectTakePhoto:(id)sender {
    AVCapturePhotoSettings *settings = [AVCapturePhotoSettings photoSettingsWithFormat:@{AVVideoCodecKey: AVVideoCodecTypeJPEG}];
    [self.stillImageOutput capturePhotoWithSettings:settings delegate:self];
}

- (IBAction)didSelectGoBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)didSelectIntro:(id)sender {
    FMIntroCameraViewController *vc = [[FMIntroCameraViewController alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
}

#pragma mark - AVCapturePhotoCaptureDelegate
- (void)captureOutput:(AVCapturePhotoOutput *)output didFinishProcessingPhoto:(AVCapturePhoto *)photo error:(nullable NSError *)error {
    
    NSData *imageData = photo.fileDataRepresentation;
    if (imageData) {
        UIImage *image = [UIImage imageWithData:imageData];
        [_listImage addObject:image];
        // Add the image to captureImageView here...
        if(!self.showImageVC) {
            self.showImageVC = [[FMCameraShowImageVC alloc] init];
        }
        self.showImageVC.listImage = _listImage;
        [self presentViewController:self.showImageVC animated:YES completion:nil];
    }
}




@end
