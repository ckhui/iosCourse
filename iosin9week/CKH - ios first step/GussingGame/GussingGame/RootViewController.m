//
//  RootViewController.m
//  GussingGame
//
//  Created by NEXTAcademy on 10/18/16.
//  Copyright © 2016 ckhui. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()
@property int secreatNumber;
@property (weak, nonatomic) IBOutlet UIButton *revealButton;
@property (weak, nonatomic) IBOutlet UILabel *secreatNumberLabel;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UILabel *guessLabel;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
@property int guessCount;
@property int previousGuess;
@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.secreatNumber = arc4random()%300+1;;
    self.guessCount = 0;
    self.previousGuess = -1;
    
    self.secreatNumberLabel.hidden = YES;
    self.textField.placeholder = @"Guess Here";
    self.textField.textAlignment = NSTextAlignmentCenter;
    self.guessLabel.textAlignment = NSTextAlignmentCenter;
    self.resultLabel.textAlignment = NSTextAlignmentCenter;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)revealAns:(id)sender {
    self.secreatNumberLabel.text = [NSString stringWithFormat:@"Secreat Number: %d", self.secreatNumber];
    self.secreatNumberLabel.hidden = NO;
}

- (IBAction)guess:(id)sender {
    //get input
    //input validation
    NSString *message;
    NSString *input = self.textField.text;
    NSCharacterSet* notDigits = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    //contain only number
    if ([input rangeOfCharacterFromSet:notDigits].location == NSNotFound){
        
        NSInteger num = [input integerValue];
        
        //check if it still the previous number
        if (num == self.previousGuess){
            //message = @"Enter another number";
            return;
        }
        else{
            self.guessCount ++;
            self.previousGuess = (int)num;
            
            if (num > self.secreatNumber){
                //larger than
                message = @"A little too high";
            }
            else if (num == self.secreatNumber){
                //correct
                message = @"Amazing";
            }
            else{
                //less than
                message = @"A little too low";
            }
        }
    }
    //contain some char other than number
    else{
        message = @"Enter only number";
    }
    
    self.resultLabel.text = message;
    self.guessLabel.text = [NSString stringWithFormat:@"Number Of Guesses: %d", self.guessCount];
    
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
