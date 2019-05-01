//
//  FMUserInforModel.m
//  FuzzyMark
//
//  Created by Tu Tran on 5/2/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import "FMUserInforModel.h"
#import "FMCellBlockObject.h"

@implementation FMUserInforModel


- (void)initDataAllCellBlockWithSuccessBlock:(void(^)(NSArray *)) successBlock {
    // block Place
    FMCellBlockObject *block1 = [[FMCellBlockObject alloc] init];
    block1.typeBlock = FMTableViewCellBlockFavoritePlaces;
    
    // block UserInfor
    FMCellBlockObject *block2 = [[FMCellBlockObject alloc] init];
    block2.typeBlock = FMTableViewCellBlockUserInfor;
    
    // block ChangePassword
    FMCellBlockObject *block3 = [[FMCellBlockObject alloc] init];
    block3.typeBlock = FMTableViewCellBlockChangePassWord;
    
    // block ChangePhoneNumber
    FMCellBlockObject *block4 = [[FMCellBlockObject alloc] init];
    block4.typeBlock = FMTableViewCellBlockChangePhoneNumber;
    
    // block Policies
    FMCellBlockObject *block5 = [[FMCellBlockObject alloc] init];
    block5.typeBlock = FMTableViewCellBlockPoliciesAndTerms;
    
    // block LogOut
    FMCellBlockObject *block6 = [[FMCellBlockObject alloc] init];
    block6.typeBlock = FMTableViewCellBlockLogOut;
    
    NSArray *listSection1 = [NSArray arrayWithObjects:block1, block2, block3, block4, nil];
    NSArray *listSection2 = [NSArray arrayWithObjects:block5, block6, nil];
    NSArray *listMenuBlock = [NSArray arrayWithObjects:listSection1, listSection2, nil];
    successBlock(listMenuBlock);
}

- (void)initDataFirstCellUserWithSuccessBlock:(void(^)(NSArray *)) successBlock {
    successBlock(nil);
}

@end
