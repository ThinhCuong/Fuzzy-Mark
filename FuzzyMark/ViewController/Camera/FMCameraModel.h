//
//  FMCameraModel.h
//  FuzzyMark
//
//  Created by Tu Tran on 5/21/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

API_AVAILABLE(ios(10.0))
@interface FMCameraModel : NSObject

@property (strong, nonatomic) AVCaptureDevice *backCamera;
@property (strong, nonatomic) AVCaptureSession *session;
@property (strong, nonatomic) AVCapturePhotoOutput *stillImageOutput;
@property (strong, nonatomic) AVCaptureVideoPreviewLayer *videoPreviewLayer;

@end

NS_ASSUME_NONNULL_END
