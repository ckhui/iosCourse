//
//  RandomViewController.m
//  Aniamation
//
//  Created by NEXTAcademy on 11/1/16.
//  Copyright © 2016 ckhui. All rights reserved.
//

#import "RandomViewController.h"
#import "RoundedButton.h"

@interface RandomViewController ()

@property UIImageView *cloudImageView;
@property UIImageView *cardImageView;
@property RoundedButton *button;

@end

@implementation RandomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.cloudImageView = [[UIImageView alloc]initWithFrame:CGRectMake(100, 50, 100, 100)];
    self.cloudImageView.image = [UIImage imageNamed:@"cloud"];
    
    [self.view addSubview:self.cloudImageView];
    
    self.cardImageView =[[UIImageView alloc] initWithFrame:CGRectMake(100, self.view.frame.size.height - 150, 100, 150)];
    
    self.cardImageView.image = [UIImage imageNamed:@"diamond_K"];
    
    UITapGestureRecognizer *flipCard = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(flipCard)];
    
    self.cardImageView.gestureRecognizers = @[flipCard];
    self.cardImageView.userInteractionEnabled = YES;
    [self.view addSubview:self.cardImageView];
    
    CGRect frame;
    frame.size = CGSizeMake(80, 80);
    frame.origin = CGPointZero;
    
    self.button = [[RoundedButton alloc] initWithFrame:frame];
    //self.button.backgroundColor = [UIColor greenColor];
    [self.view addSubview:self.button];
}

- (void) flipCard{
    [UIView transitionWithView:self.cardImageView duration:1.0 options:UIViewAnimationOptionTransitionFlipFromRight animations:^{
        self.cardImageView.image = [UIImage imageNamed:@"diamond_Q"];
    } completion:^(BOOL finished) {
        [self.cardImageView removeFromSuperview];
    }];
    
}

-(void)viewDidAppear:(BOOL)animated{
    [UIView animateWithDuration:3.0 delay:0.0 options:UIViewAnimationOptionRepeat|UIViewAnimationOptionAutoreverse animations:^{
        self.cloudImageView.center = CGPointMake(self.cloudImageView.center.x + 200, self.cloudImageView.center.y + 200);
    } completion:nil];
    
    [UIView animateWithDuration:5.0 delay:0.0 options:UIViewAnimationOptionRepeat|UIViewAnimationOptionAutoreverse animations:^{
        self.button.center = CGPointMake(self.button.center.x + 200, self.button.center.y + 200);

    } completion:nil];
    
    
    [UIView animateWithDuration:2.0 delay:0.0 options:UIViewAnimationOptionRepeat|UIViewAnimationOptionAutoreverse animations:^{
        self.button.transform = CGAffineTransformMakeScale(2.0, 2.0);

        
    } completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
