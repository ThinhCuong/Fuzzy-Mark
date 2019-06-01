//
//  CameraShowImageCell.m
//  FuzzyMark
//
//  Created by Tu Tran on 5/31/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import "CameraShowImageCell.h"

@interface CameraShowImageCell ()
@property (weak, nonatomic) IBOutlet UILabel *lblIndex;
@property (weak, nonatomic) IBOutlet UIImageView *imgPhoto;

@end
@implementation CameraShowImageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.lblIndex.layer.cornerRadius = 5;
    self.lblIndex.clipsToBounds = YES;
}

- (void)binDataIndex:(NSString *) index withImage:(UIImage *) image {
    self.lblIndex.text = index;
    self.imgPhoto.image = image;
}

@end
