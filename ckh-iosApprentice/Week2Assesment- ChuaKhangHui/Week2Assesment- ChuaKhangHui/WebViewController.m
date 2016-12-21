//
//  WebViewController.m
//  Week2Assesment- ChuaKhangHui
//
//  Created by NEXTAcademy on 10/28/16.
//  Copyright © 2016 ckhui. All rights reserved.
//

#import "WebViewController.h"


@interface WebViewController () <UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UILabel *loadingBar;

@end

@implementation WebViewController

- (void)viewDidLoad {
    self.loadingBar.hidden = NO;
    self.webView.delegate = self;
    
    NSURL *url =[NSURL URLWithString:self.webUrl];
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Webview Delegate
- (void)webViewDidStartLoad:(UIWebView *)webView{
    self.loadingBar.hidden = NO;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    self.loadingBar.hidden = YES;
}


@end
