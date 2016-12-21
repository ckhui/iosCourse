//
//  DetailsViewController.h
//  Week2Assesment- ChuaKhangHui
//
//  Created by NEXTAcademy on 10/28/16.
//  Copyright © 2016 ckhui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppleProduct.h"

@class DetailsViewController;
@protocol DetailViewControllerDelegate <NSObject>

- (void) didChangeTitleButtonClick:(DetailsViewController *)detailsViewController wtihTitle:(NSString *)newTitle;

@end

@interface DetailsViewController : UIViewController

@property (strong, nonatomic) AppleProduct *displayProduct;
@property (nonatomic, assign) id<DetailViewControllerDelegate> delegate;

@end
