//
//  AppDelegate.h
//  FuzzyMark
//
//  Created by Tu Tran on 4/11/19.
//  Copyright © 2019 Tu Tran. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "FMTabBarController.h"
#import "FMNotifiViewController.h"
#import "FMUserInforViewController.h"
#import "FZHomeViewController.h"

API_AVAILABLE(ios(10.0))
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;

// UINavigationController
@property (strong, nonatomic) FMTabBarController *tabbarController;
@property (strong, nonatomic) UINavigationController *FMNaviHomeController;
@property (strong, nonatomic) UINavigationController *FMNaviSearchController;
@property (strong, nonatomic) UINavigationController *FMNaviCameraController;
@property (strong, nonatomic) UINavigationController *naviNotifiController;
@property (strong, nonatomic) UINavigationController *naviUserInforController;

// UIViewController
@property (strong, nonatomic) FZHomeViewController *homeViewController;
@property (strong, nonatomic) UIViewController *FMSearchViewController;
@property (strong, nonatomic) UIViewController *FMCameraViewController;
@property (strong, nonatomic) FMNotifiViewController *notifiViewController;
@property (strong, nonatomic) FMUserInforViewController *userInforViewController;

@end

