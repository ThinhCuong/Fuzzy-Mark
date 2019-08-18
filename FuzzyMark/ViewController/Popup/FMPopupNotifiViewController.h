//
//  FMPopupNotifiViewController.h
//  FuzzyMark
//
//  Created by Tu Tran on 8/18/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol FMPopupNotifiDelegate <NSObject>

- (void)didSelectChooseSuccessPopup;
- (void)didSelectChooseCanclePopup;

@end

@interface FMPopupNotifiViewController : UIViewController
@property (assign, nonatomic) id<FMPopupNotifiDelegate> delegate;
@property (weak, nonatomic) IBOutlet UILabel *lbTitle;
- (instancetype)initWithTitle:(NSString *) title;
@end

NS_ASSUME_NONNULL_END
