//
//  LocationFavoriteTableViewCell.m
//  FuzzyMark
//
//  Created by Tu Tran on 5/17/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import "LocationFavoriteTableViewCell.h"
#import "CommonFunction.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface LocationFavoriteTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imgLogo;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblMoney;
@property (weak, nonatomic) IBOutlet UILabel *lblDistance;
@property (weak, nonatomic) IBOutlet UILabel *lblLocation;
@property (weak, nonatomic) IBOutlet UILabel *lblNumberRate;
@property (weak, nonatomic) IBOutlet UILabel *lblNumberComment;
@property (weak, nonatomic) IBOutlet UIButton *btnDetail;


@end

@implementation LocationFavoriteTableViewCell {
    NSInteger _idPage;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [CommonFunction setCornerRadiusUIImageView:self.imgLogo cornerRadiusValue:40];
    self.btnDetail.layer.cornerRadius = 3;
    self.btnDetail.layer.borderWidth = 1;
    self.btnDetail.layer.borderColor = [UIColor colorWithRed:0.2 green:0.6 blue:0.86 alpha:1.0].CGColor;
    
}

- (void)bindData:(RewardObject *)groupInfo currentLocation:(CLLocationCoordinate2D)currentLocation {
    [self.imgLogo sd_setImageWithURL: [NSURL URLWithString:groupInfo.image]];
    self.lblName.text = groupInfo.name;
    self.lblMoney.text = [NSString stringWithFormat:@"Hoàn tiền %ld%@", (long)groupInfo.percentDiscount, @"%"];
    self.lblLocation.text = groupInfo.page.address;
    self.lblNumberRate.text = [NSString stringWithFormat:@"%ld", (long)groupInfo.page.total_rate];
    self.lblNumberComment.text = [NSString stringWithFormat:@"(%ld)", (long)groupInfo.page.rate_count];
    
    CLLocation *locA = [[CLLocation alloc] initWithLatitude:currentLocation.latitude longitude:currentLocation.longitude];
    CLLocation *locB = [[CLLocation alloc] initWithLatitude:groupInfo.page.location.lat.doubleValue longitude:groupInfo.page.location.lng.doubleValue];
    CLLocationDistance distance = [locA distanceFromLocation:locB];
    
    if (distance < 1000) {
        self.lblDistance.text = [NSString stringWithFormat:@"%.1f m", distance];
    } else {
        self.lblDistance.text = [NSString stringWithFormat:@"%.1f km", distance / 1000];
    }
    
    _idPage = groupInfo.page.pageId;

}
- (IBAction)didSelectShowPage:(id)sender {
    if ([self.delegate respondsToSelector:@selector(showDetailPageWithID:)]) {
        [self.delegate showDetailPageWithID:_idPage];
    }
}

@end
