//
//  FZNewsInfoDetailViewController.h
//  FuzzyMark
//
//  Created by Nguyen Cuong on 8/25/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FZNewsInfoDetailViewController : FMBaseViewController

@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

- (void)callNewsFullNews:(NSString *)newsId;

@end

NS_ASSUME_NONNULL_END
