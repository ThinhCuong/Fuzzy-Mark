//
//  MVPromotionIntroCell.m
//  FuzzyMark
//
//  Created by Tu Tran on 6/19/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import "FMPromotionIntroCell.h"


@interface FMPromotionIntroCell ()

@property (weak, nonatomic) IBOutlet UILabel *lblLocation;
@property (weak, nonatomic) IBOutlet UILabel *lblPhone;
@property (weak, nonatomic) IBOutlet UILabel *lblMoney;
@property (weak, nonatomic) IBOutlet UILabel *lblDesc;

@end

@implementation FMPromotionIntroCell {
    CLLocationCoordinate2D _location;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)binData:(FzVourcherInfoObject *) model {
    PageObject *page;
    if (model.acceptedPage.count > 0) {
        page = model.acceptedPage.firstObject;
    } else {
        page = [[PageObject alloc] initWithDataDictionary:@{}];
    }
    self.lblLocation.text = page.address?:@"";
    self.lblPhone.text = page.hotline?:@"";
    self.lblMoney.text = page.range_price?:@"";
    self.lblDesc.attributedText = [CommonFunction convertHTMLString:model.intro?:@""];
    self.heightMapImage.constant = 0;
}

- (void)binDataWithPageInfo:(PageInfo *)model {
    self.lblLocation.text = model.page_view.address?:@"";
    self.lblPhone.text = model.page_view.hotline?:@"";
    self.lblMoney.text = model.page_view.range_price?:@"";
    self.lblDesc.attributedText = [CommonFunction convertHTMLString:model.descriptionPageInfo?:@""];
    self.heightMapImage.constant = 150;
    
    if (model.page_view.location.lat.length > 0 && model.page_view.location.lng.length > 0) {
        NSString *staticMapUrl = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/staticmap?center=%@&zoom=15&size=800x300&maptype=roadmap&markers=color:red%%7Clabel:FZ%%7C%@,%@&key=%@", model.page_view.name, model.page_view.location.lat, model.page_view.location.lng, kGoogleMapKey];
        NSURL *mapUrl = [NSURL URLWithString:[staticMapUrl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
        UIImage *image = [UIImage imageWithData: [NSData dataWithContentsOfURL:mapUrl]];
        self.mapImage.image = image;
    } else {
        self.heightMapImage.constant = 0;
    }
    
}

- (NSString *)makeStringFormatMoneyString:(NSInteger) totalAmount {
    NSNumberFormatter *formatter = [NSNumberFormatter new];
    [formatter setFormatterBehavior:NSNumberFormatterBehavior10_4];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [formatter setGroupingSeparator:@"."];
    [formatter setDecimalSeparator:@","];
    [formatter setMaximumFractionDigits:0];
    [formatter setMinimumFractionDigits:0];
    NSString *result = [formatter stringFromNumber:[NSNumber numberWithInteger:totalAmount]];
    return result;
}

- (IBAction)didSelectOpenGoogleMap:(id)sender {
    
    NSURL *appleURL = [NSURL URLWithString:@"http://maps.apple.com/?daddr=311+East+Buckfield+Road+Buckfield+Maine"];
    
    NSURL *googleURL = [[NSURL alloc]
                        initWithString:[NSString stringWithFormat:@"comgooglemaps://?daddr=%f,%f", _location.latitude, _location.longitude]];
    
    NSURL *googleWebURL = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"http://www.maps.google.com/maps?daddr=%f,%f",
                                                         _location.latitude, _location.longitude]];
    
    if ([[UIApplication sharedApplication] canOpenURL:appleURL]) {
        [[UIApplication sharedApplication] openURL:appleURL options:@{} completionHandler:nil];
        return;
    }
    
    if ([[UIApplication sharedApplication] canOpenURL:googleURL]) {
        [[UIApplication sharedApplication] openURL:googleURL options:@{} completionHandler:nil];
        return;
    } else {
        [[UIApplication sharedApplication] openURL:googleWebURL options:@{} completionHandler:nil];
    }
    
}

@end
