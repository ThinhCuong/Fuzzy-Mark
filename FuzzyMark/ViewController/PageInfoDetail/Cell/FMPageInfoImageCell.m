//
//  FMPageInfoImageCell.m
//  FuzzyMark
//
//  Created by Tu Tran on 8/30/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import "FMPageInfoImageCell.h"

@implementation FMPageInfoImageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)binDataWithAlbum:(AlbumView *) album {
    self.lbName.text = album.name?:@"";
    self.lbNumberImage.text = [NSString stringWithFormat:@"%ld ảnh", album.files.count];
    [self.imgContent sd_setImageWithURL:[NSURL URLWithString:album.files.firstObject?:@""] placeholderImage:kLogoPlaceholderImage];
}

@end
