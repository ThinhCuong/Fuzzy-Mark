//
//  AppDelegate.m
//  FuzzyMark
//
//  Created by Tu Tran on 4/11/19.
//  Copyright © 2019 Tu Tran. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = UIColor.whiteColor;
    [self gotoTabbarController];
    [self.window makeKeyAndVisible];
    [self setupGlobalAppearance];
    return YES;
}

//func setupGlobalAppearance(){
//    //global Appearance settings
//    let customFont = UIFont.appRegularFontWith(size: 17)
//    UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: customFont], for: .normal)
//    UITextField.appearance().substituteFontName = Constants.App.regularFont
//    UILabel.appearance().substituteFontName = Constants.App.regularFont
//    UILabel.appearance().substituteFontNameBold = Constants.App.boldFont
//}

- (void)setupGlobalAppearance {
  // [[UILabel appearance] setFont:[UIFont fontWithName:@"Muli-Regular" size:14]];
}

- (void)gotoTabbarController {
    
    [self initViewController];
    
    NSArray *listViewController = @[self.naviHomeController, self.FMNaviSearchController, self.naviRegisterPromotions, self.naviNotifiController, self.naviUserInforController];
    
    [self.tabbarController setViewControllers:listViewController];
    
    self.window.rootViewController = self.tabbarController;
    
}

- (void)initViewController {
    // init tabbar
    self.tabbarController = [[FMTabBarController alloc] init];
    
    // init Home
    self.homeViewController = [[FZHomeViewController alloc] init];
    self.naviHomeController = [[UINavigationController alloc] initWithRootViewController:self.homeViewController];
    UITabBarItem *tabbarItemHome = [[UITabBarItem alloc] initWithTitle:@"" image:[UIImage imageNamed:@"ic_home_tb"] selectedImage:[UIImage imageNamed:@"ic_home_tb"]];
    self.naviHomeController.tabBarItem = tabbarItemHome;
    
    // init Search
    self.FMSearchViewController = [[FZSearchViewController alloc] init];
    self.FMNaviSearchController = [[UINavigationController alloc] initWithRootViewController:self.FMSearchViewController];
    UITabBarItem *tabbarItemSeach = [[UITabBarItem alloc] initWithTitle:@"" image:[UIImage imageNamed:@"ic_search_selected_tb"] selectedImage:[UIImage imageNamed:@"ic_search_selected_tb"]];
    self.FMNaviSearchController.tabBarItem = tabbarItemSeach;
    
    // init Camera
    self.registerPromotiosVC = [[FMRegisterPromotionViewController alloc] init];
    self.naviRegisterPromotions = [[UINavigationController alloc] initWithRootViewController:self.registerPromotiosVC];
    UITabBarItem *tabbarItemCamera = [[UITabBarItem alloc] initWithTitle:@"" image:[UIImage imageNamed:@"ic_camera_tb"] selectedImage:[UIImage imageNamed:@"ic_camera_tb"]];
    self.naviRegisterPromotions.tabBarItem = tabbarItemCamera;
    
    // init Notifi
    self.notifiViewController = [[FMNotifiViewController alloc] init];
    self.naviNotifiController = [[UINavigationController alloc] initWithRootViewController:self.notifiViewController];
    UITabBarItem *tabbarItemNotifi = [[UITabBarItem alloc] initWithTitle:@"" image:[UIImage imageNamed:@"ic_bell_tb"] selectedImage:[UIImage imageNamed:@"ic_bell_tb"]];
    self.naviNotifiController.tabBarItem = tabbarItemNotifi;
    
    // init User
    self.userInforViewController = [[FMUserInforViewController alloc] init];
    self.naviUserInforController = [[UINavigationController alloc] initWithRootViewController:self.userInforViewController];
    UITabBarItem *tabbarItemUserInfor = [[UITabBarItem alloc] initWithTitle:@"" image:[UIImage imageNamed:@"ic_user_tb"] selectedImage:[UIImage imageNamed:@"ic_user_tb"]];
    self.naviUserInforController.tabBarItem = tabbarItemUserInfor;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}


#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"FuzzyMark"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                    */
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSString *token = [[deviceToken description] stringByTrimmingCharactersInSet: [NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    token = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSLog(@"content---%@", token);
}

@end
