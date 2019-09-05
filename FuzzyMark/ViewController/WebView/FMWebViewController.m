//
//  FMWebViewController.m
//  FuzzyMark
//
//  Created by Tu Tran on 9/5/19.
//  Copyright © 2019 Nguyen Cuong. All rights reserved.
//

#import "FMWebViewController.h"
#import <WebKit/WebKit.h>

@interface FMWebViewController () <WKNavigationDelegate>
@property (strong, nonatomic) WKWebView *webView;
@end

@implementation FMWebViewController {
    NSString *_url;
    NSString *_title;
}

#pragma mark - life cycle
- (instancetype)initWithLink:(NSString *) url andTitle:(NSString *) title
{
    self = [super init];
    if (self) {
        _url = url;
        _title = title;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navTitle = _title?:@"Chi tiết ưu đãi";
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    _webView = [[WKWebView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:_webView];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:_url]];
    [_webView loadRequest:request];
    _webView.navigationDelegate = self;
    [CommonFunction showLoadingView];
}

#pragma mark - WKNavigationDelegate
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation {
    [_webView evaluateJavaScript:@"document.title" completionHandler:^(NSString *string, NSError * _Nullable error) {
        if(!error && string.length > 0) {
            self.navTitle = string?:0;
        }
    }];
    [CommonFunction hideLoadingView];
}

@end
