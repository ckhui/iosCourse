//
//  ButtonViewController.m
//  Aniamation
//
//  Created by NEXTAcademy on 11/1/16.
//  Copyright © 2016 ckhui. All rights reserved.
//

#import "ButtonViewController.h"

@interface ButtonViewController ()

@property UIDynamicAnimator *dynamicAnimator;
@property UIGravityBehavior *gravity;
@property UIButton *startButton;
@property NSArray *optionButton;

@property BOOL isOpen;

@end

@implementation ButtonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.dynamicAnimator = [[UIDynamicAnimator alloc]initWithReferenceView:self.view];
    
    self.gravity = [[UIGravityBehavior alloc] init];
    self.gravity.magnitude = 0.3;
    
    [self.dynamicAnimator addBehavior:self.gravity];
    
    UIButton *button1 = [self creatButton:@"First" color:[UIColor blueColor]];
    UIButton *button2 = [self creatButton:@"Second" color:[UIColor greenColor]];
    UIButton *button3 = [self creatButton:@"Third" color:[UIColor redColor]];
    UIButton *button4 = [self creatButton:@"Fourth" color:[UIColor orangeColor]];
 
    self.optionButton = [[NSArray alloc] initWithObjects:button1,button2,button3,button4, nil];
    
    self.startButton = [self creatButton:@"START" color:[UIColor brownColor]];
    [self.startButton addTarget:self action:@selector(toggleMenu) forControlEvents:UIControlEventTouchUpInside];
}

- (UIButton *)creatButton:(NSString *)title color:(UIColor *)color{
    UIButton *button = [[UIButton alloc] init];
    button.frame = CGRectMake(self.view.frame.size.width/2, self.view.frame.size.height/2, 80, 80);
    
    button.layer.cornerRadius = button.frame.size.width/2;
    [button setTitle:title forState:UIControlStateNormal];
    [button setBackgroundColor:color];
    
    [self.view addSubview:button];
    
    return button;
}

-(void) toggleMenu{
    
    [self.dynamicAnimator removeAllBehaviors];
    if(self.isOpen){
        [self close];
    }
    else{
        [self open];
    }
    self.isOpen = !self.isOpen;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) open{
    int buttonNumber = 0;
    for (NSInteger i =-1 ;i <= 1; i+=2){
        for(NSInteger j = - 1; j <= 1; j+=2){
            UIButton *button = self.optionButton[buttonNumber];
            UISnapBehavior *snap = [[UISnapBehavior alloc] initWithItem:button snapToPoint:CGPointMake(button.center.x + i *80, button.center.y + j *80)];
            
            snap.damping = 0.0;
            buttonNumber ++;
            [self.dynamicAnimator addBehavior:snap];
        }
    }
}
- (void)close{
    for(UIButton *button in self.optionButton){
        UISnapBehavior *snap = [[UISnapBehavior alloc] initWithItem:button snapToPoint:self.startButton.center];
        snap.damping = 1.0;
        
        [self.dynamicAnimator addBehavior:snap];
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
