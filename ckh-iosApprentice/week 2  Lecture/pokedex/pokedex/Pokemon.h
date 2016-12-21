//
//  Pokemon.h
//  pokedex
//
//  Created by NEXTAcademy on 10/25/16.
//  Copyright © 2016 ckhui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Pokemon : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *type;
@property (strong, nonatomic) UIImage *picture;
@property (strong, nonatomic) NSString *desc;
@property (strong, nonatomic) UIImage *largePic;
//@property (strong, nonatomic)

@end
