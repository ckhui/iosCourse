//
//  Book+CoreDataProperties.m
//  bookface2
//
//  Created by NEXTAcademy on 11/4/16.
//  Copyright © 2016 ckhui. All rights reserved.
//

#import "Book+CoreDataProperties.h"

@implementation Book (CoreDataProperties)

+ (NSFetchRequest<Book *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Book"];
}

@dynamic name;
@dynamic hasComment;
@dynamic readBy;

@end
