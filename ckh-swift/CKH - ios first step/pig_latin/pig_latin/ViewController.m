//
//  ViewController.m
//  pig_latin
//
//  Created by NEXTAcademy on 10/18/16.
//  Copyright © 2016 ckhui. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *inputText;
@property (weak, nonatomic) IBOutlet UILabel *resLabel;

- (NSString *) piglatin:(NSString *)str;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.inputText.placeholder = @"Type a phase here";
    self.inputText.textAlignment = NSTextAlignmentCenter;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)tranform:(id)sender {
    NSString *input = self.inputText.text;
    if (input.length == 0){
        return;
    }
    NSMutableArray* words = [[input componentsSeparatedByString: @" "] mutableCopy];
    
    NSInteger len = [words count];
    
    for(NSInteger i =0; i <len ; i++){
        
        //unichar firstChar = [[words[i] uppercaseString] characterAtIndex:0];
        //if (firstChar >= 'A' && firstChar <= 'Z') {
            //first letter is alphabet
            words[i] = [self piglatin:words[i]];
        //}
        
    }
    
    self.resLabel.text = [words componentsJoinedByString:@" "];
}

- (NSString *)piglatin:(NSString *)str{
    
    //get first char
    char character = [str characterAtIndex:0];
    NSCharacterSet *letters = [NSCharacterSet characterSetWithCharactersInString:@"aeiouAEIOU"];
    if (![letters characterIsMember:character]) {
        // The first character is not vowel
        NSInteger len = [str length];
        for (NSInteger i = 1 ; i < len; i++){
            character = [str characterAtIndex:i];
            if ([letters characterIsMember:character]){
                //pig-latin
                return [NSString stringWithFormat:@"%@%@%@",[str substringFromIndex:i], [str substringToIndex:i], @"ay"];
            }
            
        }
        
    }
    
    return str;
}

@end
