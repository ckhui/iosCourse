//
//  Book+CoreDataClass.h
//  bookface2
//
//  Created by NEXTAcademy on 11/4/16.
//  Copyright © 2016 ckhui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Comment, User;

NS_ASSUME_NONNULL_BEGIN

@interface Book : NSManagedObject

@end

NS_ASSUME_NONNULL_END

#import "Book+CoreDataProperties.h"
