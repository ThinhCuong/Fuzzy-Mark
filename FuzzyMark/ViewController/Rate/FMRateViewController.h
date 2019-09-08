//
//  FMRateViewController.h
//  FuzzyMark
//
//  Created by Tu Tran on 9/8/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Cosmos-Swift.h>

NS_ASSUME_NONNULL_BEGIN

@interface FMRateViewController : FMBaseViewController

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet CosmosView *rateView;
@property (weak, nonatomic) IBOutlet UITextView *textView;
- (instancetype)initWithIDPage:(NSInteger) idPage;

@end

NS_ASSUME_NONNULL_END
