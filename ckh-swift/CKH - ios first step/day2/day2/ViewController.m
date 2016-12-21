//
//  ViewController.m
//  day2
//
//  Created by NEXTAcademy on 10/18/16.
//  Copyright © 2016 NEXTAcademy. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}

- (IBAction)bttUp:(id)sender {
    NSString *a = @"qweasdzxc";
    NSLog(@"%@", a);
    [a uppercaseString];
    NSLog(@"%@", a);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
