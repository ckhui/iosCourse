//
//  AnagramViewController.m
//  day2-StringManipulation
//
//  Created by NEXTAcademy on 10/18/16.
//  Copyright © 2016 NEXTAcademy. All rights reserved.
//

#import "AnagramViewController.h"

@interface AnagramViewController ()
@property (weak, nonatomic) IBOutlet UIButton *isoButton;
@property (weak, nonatomic) IBOutlet UITextField *isoInput;
@property (weak, nonatomic) IBOutlet UILabel *isoResult;

@end

@implementation AnagramViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.isoInput.placeholder = @"Type Something";
    self.isoInput.textAlignment = NSTextAlignmentCenter;
    //2nd way to declare button function
    //1st : drag
    [self.isoButton addTarget:self action:@selector(isoButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) isoButtonTapped:(id)sender{
    
    NSString *input = self.isoInput.text;
    NSInteger lenght = [input length];
    if (lenght ==0){
        self.isoResult.text = @"Type something";
        return;
    }
    
    
        
    //for (NSInteger i = 0 ; i < lenght-1; i++){
    //    char letter = [input characterAtIndex:i];
    //    NSString *subString = [input substringFromIndex:i];
    //    NSLog(@"%@",subString);
    
    for (NSInteger i = 0 ; i < lenght-1; i++){
        
        NSString *subString = [input substringFromIndex:i+1];
        //NSLog(@"%@",subString);
        char letter = [input characterAtIndex:i];
        if ([subString rangeOfString:[NSString stringWithFormat:@"%c", letter]].location != NSNotFound){
            self.isoResult.text = @"Not Iso";
            return;
        }
        
        /*
         for (NSInteger j = i+1 ; j < lenght; j++){
         if([input characterAtIndex:i] == [input characterAtIndex:j]){
         self.isoResult.text = @"Not Iso";
         return;
         }
         }
         */
    }
    
    
    self.isoResult.text = @"Is Iso";
    
    
    
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
