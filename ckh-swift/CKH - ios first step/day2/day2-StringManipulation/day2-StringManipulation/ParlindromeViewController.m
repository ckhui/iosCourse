//
//  ParlindromeViewController.m
//  day2-StringManipulation
//
//  Created by NEXTAcademy on 10/18/16.
//  Copyright © 2016 NEXTAcademy. All rights reserved.
//

#import "ParlindromeViewController.h"

@interface ParlindromeViewController ()
@property (weak, nonatomic) IBOutlet UILabel *parlidromeResult;
@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation ParlindromeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.textField.placeholder = @"Type Something";
    self.textField.textAlignment = NSTextAlignmentCenter;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)checkPalindrome:(id)sender {
    
    NSString *inputText = self.textField.text;
    
    if ([inputText length] == 0){
        self.parlidromeResult.text = @"Enter some Text";
    }
    else{
        inputText = [inputText stringByReplacingOccurrencesOfString:@" " withString:@""];
        
        Boolean isPalindrome = true;
        
        NSInteger inputLength = [inputText length];
        NSInteger halfLength = inputLength / 2;
        
        /*
         for (int i = 0; i <halfLength; i++){
         if([inputText characterAtIndex:i] != [inputText characterAtIndex:(inputLength -i -1)]){
         //not a palidrome
         isPalindrome = false;
         
         }
         }
         */
        
        NSInteger i = 0;
        while ((i < halfLength) && isPalindrome){
            if([inputText characterAtIndex:i] != [inputText characterAtIndex:(inputLength -i -1)]){
                isPalindrome = false;
            }
            i++;
        }
        
        if (isPalindrome) {
            self.parlidromeResult.text = @"YES!	";
        }
        else {
            self.parlidromeResult.text = @"NO!!";
        }
    }
    
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
