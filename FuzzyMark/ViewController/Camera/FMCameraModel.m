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
    self.backCamera = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if(!self.backCamera) {
        NSLog(@"Không tìm thấy thiết bị chupj trên điện thoại này");
        return;
    }
    
}

@end
