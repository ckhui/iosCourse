//
//  ViewController.m
//  Day3-MiniBrowser
//
//  Created by NEXTAcademy on 10/19/16.
//  Copyright © 2016 ckhui. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIWebViewDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UITextField *urlTextField;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingCircle;
@property (weak,nonatomic) IBOutlet UIButton *btn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.webView.delegate = self;
    self.urlTextField.delegate = self;
    
    [self loadPage:@"https://www.google.com"];
    self.loadingCircle.hidesWhenStopped = YES;
    
    [self.btn addTarget:self action:@selector(buttonType) forControlEvents:UIControlEventTouchUpInside];
    
    
}

     - (void) buttonTapped:(id)sender{
         
     }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    NSString *inputtedUrl = self.urlTextField.text;
    [self loadPage:inputtedUrl];
    return YES;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    NSLog(@"%@",error.description);
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Fail" message:error.description preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelButton = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action){
        [self.loadingCircle stopAnimating];
    }];
    
    
    UIAlertAction *goHome = [UIAlertAction actionWithTitle:@"Go Home" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
        [self loadPage:@"https://www.google.com"];

    }];
    
    [alertController addAction:goHome];
    [alertController addAction:cancelButton];
    [self presentViewController:alertController animated:YES completion:nil];

}

- (void)loadPage:(NSString *)urlString {
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];

}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    [self.loadingCircle startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [self.loadingCircle stopAnimating];
    
}


@end
