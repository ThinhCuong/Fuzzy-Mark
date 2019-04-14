//
//  AppDelegate.h
//  FuzzyMark
//
//  Created by Nguyen Cuong on 4/10/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@class FZHomeViewController;

API_AVAILABLE(ios(10.0))
API_AVAILABLE(ios(10.0))
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

@property (strong, nonatomic) FZHomeViewController *homeViewController;

- (void)saveContext;


@end

