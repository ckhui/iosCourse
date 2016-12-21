//
//  AppleProduct.m
//  Week2Assesment- ChuaKhangHui
//
//  Created by NEXTAcademy on 10/28/16.
//  Copyright © 2016 ckhui. All rights reserved.
//

#import "AppleProduct.h"

@implementation AppleProduct

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.name = @"name";
        self.date = @"date";
        self.url = @"url";
        self.image = [UIImage imageNamed:@"empty"];
    }
    return self;
}

- (instancetype) initWithName: (NSString *)name Date:(NSString *)date Url:(NSString *)url Image:(UIImage *) image{
    
    self = [super init];
    if (self) {
        self.name = name;
        self.date = date;
        self.url = url;
        self.image = image;
      }
    return self;
}



@end
