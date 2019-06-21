//
//  FMBaseListItemVC.h
//  FuzzyMark
//
//  Created by Tu Tran on 6/21/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FMBaseListItemVC : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *contentTableView;
@property (nonatomic, copy) void (^changeHeightContentTableView)(CGFloat);
@end

NS_ASSUME_NONNULL_END
