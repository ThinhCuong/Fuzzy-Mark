//
//  main.m
//  FuzzyMark
//
//  Created by Nguyen Cuong on 4/10/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int main(int argc, char * argv[]) {
    @autoreleasepool {
        if (@available(iOS 10.0, *)) {
            return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
        } else {
            // Fallback on earlier versions
        }
    }
}
