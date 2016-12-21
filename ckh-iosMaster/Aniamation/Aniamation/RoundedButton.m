//
//  RoundedButton.m
//  Aniamation
//
//  Created by NEXTAcademy on 11/1/16.
//  Copyright © 2016 ckhui. All rights reserved.
//

#import "RoundedButton.h"

@implementation RoundedButton


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    self.frame = CGRectMake(0, 0, 60, 60);
    self.layer.cornerRadius = self.bounds.size.width / 2;
    self.layer.backgroundColor = [UIColor grayColor].CGColor;
    //self.backgroundColor = [UIColor redColor];

}


@end
