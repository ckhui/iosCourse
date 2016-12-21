//
//  AppleProduct.h
//  Week2Assesment- ChuaKhangHui
//
//  Created by NEXTAcademy on 10/28/16.
//  Copyright © 2016 ckhui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AppleProduct : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *date; // use proper data type, use NSDate
@property (strong, nonatomic) NSString *url;
@property (strong, nonatomic) UIImage *image;

// follow the convention
// initWithName:date:url:image
- (instancetype) initWithName: (NSString *)name Date:(NSString *)date Url:(NSString *)url Image:(UIImage *) image;

@end
