//
//  FMCellBlockObject.m
//  FuzzyMark
//
//  Created by Tu Tran on 5/2/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import "FMCellBlockObject.h"

@implementation FMCellBlockObject

- (void)setTypeBlock:(FMTableViewCellBlock)typeBlock {
    _typeBlock = typeBlock;
    switch (self.typeBlock) {
        case FMTableViewCellBlockFavoritePlaces:
            self.title = @"Địa điểm quan tâm";
            self.image = [UIImage imageNamed:@"ic_placeholder"];
            break;
        case FMTableViewCellBlockUserInfor:
            self.title = @"Thông tin cá nhân";
            self.image = [UIImage imageNamed:@"ic_use_block"];
            break;
        case FMTableViewCellBlockChangePassWord:
            self.title = @"Thay đổi mật khẩu";
            self.image = [UIImage imageNamed:@"ic_password"];
            break;
        case FMTableViewCellBlockChangePhoneNumber:
            self.title = @"Thay đổi số điện thoại";
            self.image = [UIImage imageNamed:@"ic_phone"];
            break;
        case FMTableViewCellBlockPoliciesAndTerms:
            self.title = @"Chính sách & điều khoản";
            self.image = [UIImage imageNamed:@"ic_hand"];
            break;
        case FMTableViewCellBlockLogOut:
            self.title = @"Đăng xuất";
            self.image = [UIImage imageNamed:@"ic_sign_out"];
            break;
        default:
            break;
    }
}

@end
