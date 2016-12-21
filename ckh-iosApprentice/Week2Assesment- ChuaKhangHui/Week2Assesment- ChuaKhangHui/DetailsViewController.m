//
//  DetailsViewController.m
//  Week2Assesment- ChuaKhangHui
//
//  Created by NEXTAcademy on 10/28/16.
//  Copyright © 2016 ckhui. All rights reserved.
//

#import "DetailsViewController.h"
#import "WebViewController.h"

@interface DetailsViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *dateTextField;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *editButton;


@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = self.displayProduct.name;
    self.nameTextField.text = self.displayProduct.name;
    self.dateTextField.text = self.displayProduct.date;
    self.imageView.image = self.displayProduct.image;
    
    self.nameTextField.enabled = NO;
    self.dateTextField.enabled = NO;
    self.nameTextField.hidden = YES;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - button Funtion
- (IBAction)onWikiButtonClicked:(id)sender {
    [self performSegueWithIdentifier:@"toWebView" sender:self];
}

- (IBAction)onChangeTitleClicked:(id)sender {
    [self.delegate didChangeTitleButtonClick:self wtihTitle:self.displayProduct.name];
}

- (IBAction)onEditButtonPressed:(id)sender {
    if(self.nameTextField.isEnabled){
        //hide name label
        self.nameTextField.hidden = YES;
        
        //save change
        [self saveChange];
        
        self.nameTextField.enabled = NO;
        self.dateTextField.enabled = NO;
        [self.editButton setTitle:@"Edit"];
    }
    else{
        //shoe name label
        self.nameTextField.hidden = NO;
        
        self.nameTextField.enabled = YES;
        self.dateTextField.enabled = YES;
        [self.editButton setTitle:@"Done"];
    }
}

- (void) saveChange{
    self.displayProduct.name = self.nameTextField.text;
    self.displayProduct.date = self.dateTextField.text;
    self.title = self.nameTextField.text;
    
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"toWebView"])
    {
        
        WebViewController *destinationController = [segue destinationViewController];
        
        destinationController.webUrl = self.displayProduct.url;
    }
}

@end
