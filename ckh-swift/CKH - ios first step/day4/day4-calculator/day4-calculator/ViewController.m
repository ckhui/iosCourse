//
//  ViewController.m
//  day4-calculator
//
//  Created by NEXTAcademy on 10/20/16.
//  Copyright © 2016 ckhui. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *bttCollection;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *orangeButton;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *digitButton;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *operationButton;
@property (weak, nonatomic) IBOutlet UILabel *displayLabel;
@property bool userHasBegunTyping;
@property bool operatorPressed;
@property bool doCalculate;
@property NSString *savedOperator;
@property NSString *saveNumber;
@property NSInteger secondNumber;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.userHasBegunTyping = NO;
    self.operatorPressed = NO;
    self.saveNumber = nil;
    self.doCalculate = NO;
    self.savedOperator = @"+";
    
    
    for(UIButton *button in self.bttCollection) {
        button.layer.borderWidth = 1.0;
        button.layer.borderColor = [[UIColor grayColor] CGColor];
        button.layer.backgroundColor = [[UIColor lightGrayColor] CGColor];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    
    for(UIButton *button in self.orangeButton) {
        button.layer.backgroundColor = [[UIColor orangeColor] CGColor];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
    }
    
    for(UIButton *button in self.digitButton) {
        [button addTarget:self
                   action:@selector(onDigitButtonPressed:)
    forControlEvents:UIControlEventTouchUpInside];
    }
    
    for(UIButton *button in self.operationButton) {
        [button addTarget:self
                   action:@selector(onOperationButtonPressed:)
         forControlEvents:UIControlEventTouchUpInside];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onDigitButtonPressed:(UIButton *)sender {
    //NSLog(@"%@", sender.titleLabel.text);zz
    
    //clear the screen
    if(!(self.userHasBegunTyping)){
        self.displayLabel.text = @"";
    }
    //max length = 9
    if(self.displayLabel.text.length == 9){
        return;
    }
    
    //prevent 0 at first place
    if(self.userHasBegunTyping){
        self.displayLabel.text = [self.displayLabel.text stringByAppendingString:sender.titleLabel.text];
    }
    else{
        if ([sender.titleLabel.text isEqualToString:@"0"]){
            return;
        }
        self.displayLabel.text = sender.titleLabel.text;
        self.userHasBegunTyping = YES;
    }
}

- (IBAction)onOperationButtonPressed:(UIButton *)sender {

    NSLog(@"a--------   %@",self.savedOperator);
    
    if (self.userHasBegunTyping == NO){
        self.savedOperator = sender.titleLabel.text;
        return;
    }

    
    
    self.doCalculate = YES;
    
    //waiting for next operator pressed
    self.operatorPressed = NO;
    
    //calculate
    NSInteger answer;
    if (self.doCalculate){
        self.doCalculate = NO;
        NSString *operator = self.savedOperator;
        if([operator isEqual:@"+"]){
            NSInteger firstNumber = [ self.saveNumber integerValue];
            self.secondNumber = [self.displayLabel.text integerValue];
            answer = firstNumber + self.secondNumber;
            NSLog(@"%ld", (long)answer);
            self.displayLabel.text = [NSString stringWithFormat:@"%ld", (long)answer];
        }
        else if([operator isEqual:@"-"]){
            NSInteger firstNumber = [ self.saveNumber integerValue];
            self.secondNumber = [self.displayLabel.text integerValue];
            answer = firstNumber - self.secondNumber;
            NSLog(@"%ld", (long)answer);
            //self.displayLabel.text = [NSString stringWithFormat:@"%ld", (long)answer];
        }
        else if([operator isEqual:@"x"]){
            NSInteger firstNumber = [ self.saveNumber integerValue];
            self.secondNumber = [self.displayLabel.text integerValue];
            answer = firstNumber * self.secondNumber;
            NSLog(@"%ld", (long)answer);
            //self.displayLabel.text = [NSString stringWithFormat:@"%ld", (long)answer];
        }
        else if([operator isEqual:@"÷"]){
            NSInteger firstNumber = [ self.saveNumber integerValue];
            self.secondNumber = [self.displayLabel.text integerValue];
            answer = firstNumber / self.secondNumber;
            NSLog(@"%ld", (long)answer);
            //self.displayLabel.text = [NSString stringWithFormat:@"%ld", (long)answer];
        }
        else if([operator isEqual:@"±"]){
            NSInteger firstNumber = [ self.saveNumber integerValue];
            answer = -1 * firstNumber;
            NSLog(@"%ld", (long)answer);
            self.displayLabel.text = [NSString stringWithFormat:@"%ld", (long)answer];
        }
        
        //limit to 9 digit
        answer = MIN(answer, 999999999);
        
        //update answer
        self.saveNumber = [NSString stringWithFormat:@"%ld", (long)answer];
        
        //show answer
        self.displayLabel.text = [NSString stringWithFormat:@"%ld", (long)answer];
    }
    
    //first press
    if (!(self.operatorPressed)){
        //save operater
        self.savedOperator = sender.titleLabel.text;
        
        //waiting for 2nd input
        self.userHasBegunTyping = NO;
        
        self.operatorPressed = YES;
        
        
    }
    
    //repeat press
    else{
        //save the last pressed operater
        self.savedOperator = sender.titleLabel.text;
        return;
    }
}

- (IBAction)equalButtoPressed:(id)sender {
    
    NSInteger answer;
    NSString *operator = self.savedOperator;
    if([operator isEqual:@"+"]){
        NSInteger firstNumber = [ self.saveNumber integerValue];
        answer = firstNumber + self.secondNumber;
    }
    else if([operator isEqual:@"-"]){
        NSInteger firstNumber = [ self.saveNumber integerValue];
        answer = firstNumber - self.secondNumber;
    }
    else if([operator isEqual:@"x"]){
        NSInteger firstNumber = [ self.saveNumber integerValue];
        answer = firstNumber * self.secondNumber;
    }
    else if([operator isEqual:@"÷"]){
        NSInteger firstNumber = [ self.saveNumber integerValue];
        answer = firstNumber / self.secondNumber;
    }
   
    self.saveNumber = [NSString stringWithFormat:@"%ld", (long)answer];
    self.displayLabel.text = [NSString stringWithFormat:@"%ld", (long)answer];
    
    self.userHasBegunTyping = NO;
}

- (IBAction)onACButtonPressed:(id)sender {
    self.saveNumber = nil;
    self.operatorPressed = NO;
    self.userHasBegunTyping = NO;
    self.displayLabel.text = @"0";
    self.secondNumber = 0;
    self.savedOperator = @"+";
    
}

- (IBAction)plusMinueSignPressed:(id)sender {
    NSInteger answer = [self.saveNumber integerValue];
    self.saveNumber = [NSString stringWithFormat:@"-%ld", (long)-answer];
    self.displayLabel.text = [NSString stringWithFormat:@"%-ld", (long)-answer];
}


@end
