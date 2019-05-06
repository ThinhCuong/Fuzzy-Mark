//
//  FMTabBarController.m
//  FuzzyMark
//
//  Created by Tu Tran on 4/13/19.
//  Copyright © 2019 Tu Tran. All rights reserved.
//

#import "FMTabBarController.h"

@interface FMTabBarController ()

@end

@implementation FMTabBarController

- (void)viewDidLoad  {
    [super viewDidLoad];
    UITabBar.appearance.barTintColor = UIColor.whiteColor;
    if (@available(iOS 10.0, *)) {
        UITabBar.appearance.unselectedItemTintColor = UIColor.blackColor;
    } else {
        // Fallback on earlier versions
    }
    UINavigationBar.appearance.titleTextAttributes = @{NSFontAttributeName:[UIFont setBoldFontMuliWithSize:14], NSForegroundColorAttributeName:[UIColor blackColor]};
    UIImage *backImage = [UIImage imageNamed:@"ic_back_nv"];
    backImage = [backImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UINavigationBar.appearance.barTintColor = UIColor.whiteColor;
    UINavigationBar.appearance.backIndicatorImage = backImage;
    UINavigationBar.appearance.backIndicatorTransitionMaskImage = backImage;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // Remove the titles and adjust the inset to account for missing title
    int numberItem = 0;
    for(UITabBarItem * tabBarItem in self.tabBar.items){
        tabBarItem.title = @"";
        if(numberItem == 2) {
            [self initMiddleButton:tabBarItem.image];
            tabBarItem.image = nil;
            tabBarItem.enabled = NO;
        } else {
            tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
        }
        numberItem++;
    }
}

- (void)initMiddleButton:(UIImage *) imgButton {
    if(self.middleButton) {
        return;
    }
    self.middleButton = [FMMiddleButton buttonWithType:UIButtonTypeCustom];
    
    CGRect frame;
    frame.size.width = 49;
    frame.size.height = 49;
    frame.origin.x = self.view.bounds.size.width / 2 - frame.size.width / 2;
    frame.origin.y = self.tabBar.frame.origin.y - frame.size.height / 2 + 10;
    self.middleButton.frame = frame;
    
    self.middleButton.layer.cornerRadius = self.middleButton.frame.size.height / 2;
    self.middleButton.clipsToBounds = YES;
    [self gradientBoderColorMiddleButton];
    self.middleButton.backgroundColor = UIColor.whiteColor;
    
    [self.middleButton setImage:imgButton forState:UIControlStateNormal];
    
    [self.middleButton addTarget:self action:@selector(didSelectMiddleButton) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.middleButton];
    [self.middleButton bringSubviewToFront:self.view];
}

- (void)gradientBoderColorMiddleButton {
    UIColor *topColor = [UIColor colorWithRed:0.83 green:0.83 blue:0.83 alpha:1.0];
    UIColor *middleColor = [UIColor colorWithRed:0.85 green:0.85 blue:0.85 alpha:0.51];
    UIColor *bottomColor = [UIColor colorWithRed:0.75 green:0.75 blue:0.75 alpha:0.0];
    NSArray *gradientColors = [NSArray arrayWithObjects:(id)topColor.CGColor, middleColor.CGColor,(id)bottomColor.CGColor, nil];
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.colors = gradientColors;
    gradient.frame = CGRectMake(0, 0, self.middleButton.frame.size.width, self.middleButton.frame.size.height);
    gradient.locations = @[@0.0, @0.49, @1.0];
    
    CAShapeLayer *shapeLayer =[[CAShapeLayer alloc] init];
    shapeLayer.lineWidth = 1.0;
    shapeLayer.path = [UIBezierPath bezierPathWithRoundedRect:self.middleButton.bounds cornerRadius:self.middleButton.frame.size.height / 2].CGPath;
    shapeLayer.fillColor = nil;
    
    gradient.mask = shapeLayer;
    
    shapeLayer.strokeColor = [UIColor blackColor].CGColor;
    
    [self.middleButton.layer insertSublayer:gradient atIndex:0];
}

- (void)didSelectMiddleButton {
    [self.middleButton selectedButton];
    [self setSelectedIndex:2];
}

#pragma mark - UITabBarDelegate
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    [self.middleButton unselectedButton];
}
    
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
