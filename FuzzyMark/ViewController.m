//
//  ViewController.m
//  FuzzyMark
//
//  Created by Nguyen Cuong on 4/10/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import "ViewController.h"
#import "BaseCallApi.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self testApi];
}

- (void)testApi {
    BaseCallApi *http = [[BaseCallApi alloc] initWithBaseURL:@"https://devtools-ntt.herokuapp.com/api/MyViettel/"];
    [http postDataWithPath:@"apiMediaOne/get-province" andParam:nil isShowfailureAlert:YES withSuccessBlock:^(id responseData) {
        if (responseData) {
            
        }
    } withFailBlock:^(id error) {
        if (error) {
            
        }
    }];
}
@end
