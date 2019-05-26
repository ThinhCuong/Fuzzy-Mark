//
//  FMCameraModel.m
//  FuzzyMark
//
//  Created by Tu Tran on 5/21/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import "FMCameraModel.h"

@implementation FMCameraModel

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
        self.videoPreviewLayer.videoGravity = AVLayerVideoGravityResizeAspect;
        self.videoPreviewLayer.connection.videoOrientation = AVCaptureVideoOrientationPortrait;
//        [self.pre]
    }
}

@end
