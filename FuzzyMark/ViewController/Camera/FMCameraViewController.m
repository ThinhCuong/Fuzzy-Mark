//
//  FMCameraViewController.m
//  FuzzyMark
//
//  Created by Tu Tran on 5/3/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import "FMCameraViewController.h"

@interface FMCameraViewController () <AVCapturePhotoCaptureDelegate>
@property (weak, nonatomic) IBOutlet UIView *previewView;
@property (weak, nonatomic) IBOutlet UIView *blurView;
@property (weak, nonatomic) IBOutlet UIView *middleView;
@property (weak, nonatomic) IBOutlet UIView *introView;


@property (strong, nonatomic) AVCaptureSession *session;
@property (strong, nonatomic) AVCapturePhotoOutput *stillImageOutput;
@property (strong, nonatomic) AVCaptureVideoPreviewLayer *videoPreviewLayer;
@end

@implementation FMCameraViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.introView setAlpha:0.0];
    [self setNavigationBar];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    // Setup your camera here...
    [self greateNewSession];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.session stopRunning];
}

#pragma mark private
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

- (void)setNavigationBar {
    self.isHideNavigationBar = YES;
}


- (void)greateNewSession {
    self.session = [AVCaptureSession new];
    self.session.sessionPreset = AVCaptureSessionPresetPhoto;
    AVCaptureDevice *backCamera = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if(!backCamera) {
        NSLog(@"Thiet bi khong co Camera");
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
    }
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
                [self setBlurView];
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
    
}

#pragma mark - AVCapturePhotoCaptureDelegate
- (void)captureOutput:(AVCapturePhotoOutput *)output didFinishProcessingPhoto:(AVCapturePhoto *)photo error:(nullable NSError *)error {
    
    NSData *imageData = photo.fileDataRepresentation;
    if (imageData) {
        UIImage *image = [UIImage imageWithData:imageData];
        // Add the image to captureImageView here...
    }
}



@end
