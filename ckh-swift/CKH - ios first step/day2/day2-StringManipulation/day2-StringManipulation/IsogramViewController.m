//
//  IsogramViewController.m
//  day2-StringManipulation
//
//  Created by NEXTAcademy on 10/18/16.
//  Copyright © 2016 NEXTAcademy. All rights reserved.
//

#import "IsogramViewController.h"

@interface IsogramViewController ()
@property (weak, nonatomic) IBOutlet UITextField *text1;
@property (weak, nonatomic) IBOutlet UITextField *text2;
@property (weak, nonatomic) IBOutlet UILabel *anaResult;

@end

@implementation IsogramViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.text1.placeholder = @"Text 1";
    self.text1.textAlignment = NSTextAlignmentCenter;
    self.text2.placeholder = @"Text 2";
    self.text2.textAlignment = NSTextAlignmentCenter;
    [self.text2 setTintColor:[UIColor greenColor]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)anaButtonTap:(id)sender {
    NSString *str1 = [[self.text1.text stringByReplacingOccurrencesOfString:@" " withString:@""] uppercaseString];
    NSString *str2 = [[self.text2.text stringByReplacingOccurrencesOfString:@" " withString:@""] uppercaseString];
    
    NSInteger len1 = [str1 length];
    NSInteger len2 = [str2 length];

    if (len1 == 0 || len2 ==0){
        self.anaResult.text = @"Enter 2 text";
    }
    
    
    if(len1 != len2){
        self.anaResult.text = @"Nope";
        return;
    }
    
    for (int i =0; i < len1 ; i ++){
        char letter = [str1 characterAtIndex:i];
        
        NSRange rangeLetter = [str2 rangeOfString:[NSString stringWithFormat:@"%c", letter]];
        
        if (rangeLetter.location == NSNotFound){
            //nope
            self.anaResult.text = @"Nope";
            return;
        }
        
        else{
            [str2 stringByReplacingCharactersInRange:rangeLetter withString:@""];
        }
        //int k = 0;
        //int h = 0;
        //for(int j =0; j<len1 ; j++){
        //    if([str1 characterAtIndex:j] == a){
        //        k++;
        //    }
        //   if([str1 characterAtIndex:j] == a){
        //        j++;
        //    }
        
    }
    
    self.anaResult.text = @"Yes";
    



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
