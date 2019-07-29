

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FMChoicePictureModel : NSObject

- (void)showOptionsCameraAndLibrary:(UIViewController *)presentVC selectedImage:(void (^)(id))selectedImageBlock;
@end

NS_ASSUME_NONNULL_END
