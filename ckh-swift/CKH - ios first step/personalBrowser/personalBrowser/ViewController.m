//
//  ViewController.m
//  personalBrowser
//
//  Created by NEXTAcademy on 10/19/16.
//  Copyright © 2016 ckhui. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIWebViewDelegate, UITextFieldDelegate, UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *variableWebView;
@property (weak, nonatomic) IBOutlet UITextField *urlTextField;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingCircle;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIButton *forwardButton;
@property (weak, nonatomic) IBOutlet UIView *topViewGroup;

@property (nonatomic, assign) CGFloat lastPosition;
@property NSInteger scrollDown;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.variableWebView.delegate = self;
    self.urlTextField.delegate = self;
    self.loadingCircle.hidesWhenStopped = YES;
    self.urlTextField.placeholder = @"Enter URL here";
    self.variableWebView.scrollView.delegate = self;
    self.scrollDown = 0;
    
    NSURL *url = [NSURL URLWithString:@"https://www.google.com"];
    NSURLRequest *requst = [NSURLRequest requestWithURL:url];
    [self.variableWebView loadRequest:requst];
    [self checkBackForward];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    NSString *inputUrl = self.urlTextField.text;
    [self loadPage:inputUrl];
    
    return YES;
}

- (IBAction)goButtonPressed:(id)sender {
    NSString *inputUrl = self.urlTextField.text;
    [self loadPage:inputUrl];
}

- (void) loadPage:(NSString *)inputUrl{
    
    //prefix
    if ([inputUrl rangeOfString:@"."].location == NSNotFound)
    {
     inputUrl = [NSString stringWithFormat:@"https://www.%@.com",inputUrl];
    }
    else if (![inputUrl containsString:@"https://"]){
        inputUrl = [NSString stringWithFormat:@"https://%@",inputUrl];
    }

    
    NSURL *url = [NSURL URLWithString:inputUrl];
    NSURLRequest *requst = [NSURLRequest requestWithURL:url];
    [self.variableWebView loadRequest:requst];
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    [self.loadingCircle startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [self.loadingCircle stopAnimating];
    
    NSString *currentURL = self.variableWebView.request.URL.absoluteString;
    self.urlTextField.text = currentURL;
    
    [self checkBackForward];
}

- (IBAction)clearButtonPressed:(id)sender {
    self.urlTextField.text = nil;
}

- (IBAction)onBackButtonPressed:(id)sender {
    //go back method
    if ([self.variableWebView canGoBack]) {
        [self.variableWebView goBack];
    }
}

- (IBAction)onForwardButtonPressed:(id)sender {
    //go forward method
    if ([self.variableWebView canGoForward]) {
        [self.variableWebView goForward];
    }
}
    
- (void) checkBackForward{
    
    self.forwardButton.enabled = NO;
    self.backButton.enabled = NO;
    
    if ([self.variableWebView canGoForward]) {
        self.forwardButton.enabled = YES;
    }
    
    if ([self.variableWebView canGoBack]) {
        self.backButton.enabled = YES;
    }
        
}

- (IBAction)onStopLoadingButtonPressed:(id)sender {
    //stop loading method
    [self.variableWebView stopLoading];
    [self.loadingCircle stopAnimating];
}

- (IBAction)onReloadButtonPressed:(id)sender {
    //reload
    [self.variableWebView reload];
}

- (IBAction)newTabPressed:(id)sender {
    UIAlertController *comingSoon = [UIAlertController alertControllerWithTitle:@"Coming Soon" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    
    //cancel button
    UIAlertAction *cancelComingSoon = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    
    [comingSoon addAction:cancelComingSoon];
    [self presentViewController:comingSoon animated:YES completion:nil];

}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    
    if (self.lastPosition > scrollView.contentOffset.y){
        //down
        self.scrollDown = MIN(self.scrollDown+1,40);
        
    }
    else if (self.lastPosition < scrollView.contentOffset.y){
        //up
        self.scrollDown = MAX(self.scrollDown-1,0);
    }
    
    if(scrollView.contentOffset.y <10){
        //top
        self.scrollDown = 40;
    }

    self.lastPosition = scrollView.contentOffset.y;
    
    
    // do whatever you need to with scrollDirection here.
    self.topViewGroup.alpha = self.scrollDown /40.0;
}



@end
