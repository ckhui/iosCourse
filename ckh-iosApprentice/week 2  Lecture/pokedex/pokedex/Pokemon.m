//
//  Pokemon.m
//  pokedex
//
//  Created by NEXTAcademy on 10/25/16.
//  Copyright © 2016 ckhui. All rights reserved.
//

#import "Pokemon.h"

@implementation Pokemon

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.name = @"Unknown";
        self.type = @"Unknown";
        self.desc = @"Unknown";
        self.picture = [UIImage imageNamed:@"unknown"];
    }
    return self;
}

@end
