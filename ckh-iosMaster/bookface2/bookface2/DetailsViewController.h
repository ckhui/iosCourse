//
//  DetailsViewController.h
//  BookFace
//
//  Created by NEXTAcademy on 11/3/16.
//  Copyright © 2016 ckhui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Book+CoreDataClass.h"

@class DetailsViewController;
@protocol DetailViewControllerDelegate <NSObject>

- (void) addNewBookWithName:(NSString *)bookName;

@end

@interface DetailsViewController : UIViewController

@property bool newBook;
@property Book *book;
@property (nonatomic,assign) id<DetailViewControllerDelegate>delegate;
@end
