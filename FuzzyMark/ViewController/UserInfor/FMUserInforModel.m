//
//  FMUserInforModel.m
//  FuzzyMark
//
//  Created by Tu Tran on 5/2/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import "FMUserInforModel.h"
#import "FMCellBlockObject.h"

@implementation FMUserInforModel {
    BaseCallApi *_httpClient;
}

#pragma mark - life cycle
- (instancetype)init
{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadData) name:kNotificationCenterChangeStatusUser object:nil];
        _httpClient = [BaseCallApi defaultInitWithBaseURL];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - public
- (void)loadData {
    [self initDataFirstCellUserWithSuccessBlock:^(UserInformation *userInfo) {
        [self.delegate reLoadUserCell:userInfo];
    }];
    [self initDataAllCellBlockWithSuccessBlock:^(NSArray *listMenuBlock) {
        [self.delegate reLoadBlockCell:listMenuBlock];
    }];
}

#pragma mark - private
- (void)initDataAllCellBlockWithSuccessBlock:(void(^)(NSArray *)) successBlock {
    NSMutableArray *listSection1 = [[NSMutableArray alloc] init];
    NSMutableArray *listSection2 = [[NSMutableArray alloc] init];
    
    // block Place
    FMCellBlockObject *block1 = [[FMCellBlockObject alloc] init];
    block1.typeBlock = FMTableViewCellBlockFavoritePlaces;
    [listSection1 addObject:block1];
    
    // block UserInfor
    FMCellBlockObject *block2 = [[FMCellBlockObject alloc] init];
    block2.typeBlock = FMTableViewCellBlockUserInfor;
    [listSection1 addObject:block2];
    
    // block ChangePassword
    FMCellBlockObject *block3 = [[FMCellBlockObject alloc] init];
    block3.typeBlock = FMTableViewCellBlockChangePassWord;
    [listSection1 addObject:block3];
    
    // block ChangePhoneNumber
    FMCellBlockObject *block4 = [[FMCellBlockObject alloc] init];
    block4.typeBlock = FMTableViewCellBlockChangePhoneNumber;
    [listSection1 addObject:block4];
    
    // block Policies
    FMCellBlockObject *block5 = [[FMCellBlockObject alloc] init];
    block5.typeBlock = FMTableViewCellBlockPoliciesAndTerms;
    [listSection2 addObject:block5];
    
    // block LogOut
    if (isLoggedIn) {
        FMCellBlockObject *block6 = [[FMCellBlockObject alloc] init];
        block6.typeBlock = FMTableViewCellBlockLogOut;
        [listSection2 addObject:block6];
    }
    
    NSArray *listMenuBlock = [NSArray arrayWithObjects:listSection1, listSection2, nil];
    successBlock(listMenuBlock);
}

- (void)initDataFirstCellUserWithSuccessBlock:(void(^)(UserInformation *)) successBlock {
    if (isLoggedIn) {
        UserInformation *userInfo = [UserInfo getUserInforModel];
        successBlock(userInfo);
    } else {
        successBlock(nil);
    }
}

- (void)uploadAvatar:(UIImage *) avatar withSuccessBlock:(void (^) (BOOL)) successBlock {
    NSDictionary *params = @{@"img": [self convertImageToBase64String:avatar]};
    [CommonFunction showLoadingView];
    [_httpClient postDataWithPath:@"user/upload-avatar" andParam:params isShowfailureAlert:YES withSuccessBlock:^(id success) {
        [CommonFunction hideLoadingView];
        if([success isKindOfClass:NSDictionary.class]) {
            if ([success codeForKey:@"error_code"] == 0) {
                NSDictionary *data = [success dictionaryForKey:@"data"];
                [UserInfo setUserAvatar:[data stringForKey:@"url"]];
                successBlock(YES);
            } else {
                [CommonFunction showToast:[success stringForKey:@"message"]];
                successBlock(NO);
            }
        } else {
            [CommonFunction showToast:[success stringForKey:kMessageError]];
            successBlock(NO);
        }
    } withFailBlock:^(id fail) {
        [CommonFunction hideLoadingView];
        [CommonFunction showToast:kMessageError];
        successBlock(NO);
    }];
}

- (NSString *)convertImageToBase64String:(UIImage *)image {
    if(image != nil) {
        NSData *imageData = UIImageJPEGRepresentation(image,0.5f);
        NSString *base64String = [imageData base64EncodedStringWithOptions:0];
        base64String = [NSString stringWithFormat:@"data:image/jpg;base64,%@",base64String];
        return base64String?:@"";
    }
    return @"";
}

@end
