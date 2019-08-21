//
//  AppDelegate.h
//  FuzzyMark
//
//  Created by Tu Tran on 4/11/19.
//  Copyright © 2019 Tu Tran. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "FMBaseViewController.h"
#import "FMTabBarController.h"
#import "FMNotifiViewController.h"
#import "FMUserInforViewController.h"
#import "FZHomeViewController.h"
#import "FMRegisterPromotionViewController.h"
#import "FZSearchViewController.h"

#define appDelegate ((AppDelegate *)[[UIApplication sharedApplication] delegate])

@interface AppDelegate : UIResponder <UIApplicationDelegate, UINavigationControllerDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;

// UINavigationController
@property (strong, nonatomic) FMTabBarController *tabbarController;
@property (strong, nonatomic) UINavigationController *naviHomeController;
@property (strong, nonatomic) UINavigationController *FMNaviSearchController;
@property (strong, nonatomic) UINavigationController *naviRegisterPromotions;
@property (strong, nonatomic) UINavigationController *naviNotifiController;
@property (strong, nonatomic) UINavigationController *naviUserInforController;

// UIViewController
@property (strong, nonatomic) FZHomeViewController *homeViewController;
@property (strong, nonatomic) FZSearchViewController *FMSearchViewController;
@property (strong, nonatomic) FMRegisterPromotionViewController *registerPromotiosVC;
@property (strong, nonatomic) FMNotifiViewController *notifiViewController;
@property (strong, nonatomic) FMUserInforViewController *userInforViewController;

- (void)loginRequiredWithSuccessBlock:(void(^)(BOOL)) successBlock;

@end

