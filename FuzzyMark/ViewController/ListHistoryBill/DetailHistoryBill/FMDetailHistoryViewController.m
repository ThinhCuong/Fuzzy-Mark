//
//  FMDetailHistoryViewController.m
//  FuzzyMark
//
//  Created by Tu Tran on 5/19/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import "FMDetailHistoryViewController.h"
#import "TransactionInfoObject.h"

@interface FMDetailHistoryViewController ()
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblFullName;
@property (weak, nonatomic) IBOutlet UILabel *lblLocation;
@property (weak, nonatomic) IBOutlet UILabel *lblStatus;
@property (weak, nonatomic) IBOutlet UILabel *lblContent;
@property (weak, nonatomic) IBOutlet UILabel *lblCode;
@property (weak, nonatomic) IBOutlet UILabel *lblTimeGive;
@property (weak, nonatomic) IBOutlet UILabel *lblRequest;
@property (weak, nonatomic) IBOutlet UILabel *lblAccep;
@property (weak, nonatomic) IBOutlet UIImageView *imgBill;
@property (weak, nonatomic) IBOutlet UIButton *btnRequest;
@property (weak, nonatomic) IBOutlet UIButton *btnSupport;


@end

@implementation FMDetailHistoryViewController {
    NSInteger _idDetail;
    BaseCallApi *httpClient;
}

- (instancetype)initWithID:(NSInteger) idDetail
{
    self = [super init];
    if (self) {
        _idDetail = idDetail;
        httpClient = [BaseCallApi defaultInitWithBaseURL];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navTitle = @"Thông tin giao dịch";
    [self getUserBillDetail];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)binData:(TransactionInfoObject *) model {
    self.lblName.text = model.transaction_view.voucher.name ?: @"";
    self.lblFullName.text = model.transaction_view.voucher.page.name ?:@"";
    self.lblLocation.text = model.transaction_view.voucher.page.address ?:@"";
    if(model.transaction_view.status == 0) {
        self.lblStatus.text = @"Từ chối";
    } else if(model.transaction_view.status == 1) {
        self.lblStatus.text = @"Chấp nhận";
    }
    self.lblContent.text = model.transaction_view.voucher.descriptionVoucher ?:@"";
    self.lblCode.text = [@(model.transaction_view.transaction_id) stringValue];
    self.lblTimeGive.text = model.time_take_voucher;
    self.lblRequest.text = model.time_send_request;
    self.lblAccep.text = model.time_check;
    if (model.images.count > 0) {
        [self.imgBill sd_setImageWithURL:[NSURL URLWithString:model.images.firstObject.url?:@""]];
    }
}

- (void)getUserBillDetail {
    [CommonFunction showLoadingView];
    NSDictionary *param = @{@"id": @(_idDetail)};
    [httpClient getDataWithPath:GET_USER_BILL_DETAIL andParam:param isSendToken:YES isShowfailureAlert:YES withSuccessBlock:^(id _Nullable success) {
        [CommonFunction hideLoadingView];
        if ([success isKindOfClass:NSDictionary.class]) {
            if ([success codeForKey:@"error_code"] == 0) {
                TransactionInfoObject *obj = [[TransactionInfoObject alloc] initWithDataDictionary:[success dictionaryForKey:@"data"]];
                [self binData:obj];
            } else {
                [CommonFunction showToast:[success stringForKey:@"message"]];
            }
        } else {
            [CommonFunction showToast:kMessageError];
        }
    } withFailBlock:^(id _Nullable fail) {
        [CommonFunction showToast:kMessageError];
    }];
}


@end
