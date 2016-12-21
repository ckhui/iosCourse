//
//  Teacher+CoreDataProperties.m
//  StudentTable
//
//  Created by NEXTAcademy on 11/3/16.
//  Copyright © 2016 ckhui. All rights reserved.
//

#import "Teacher+CoreDataProperties.h"

@implementation Teacher (CoreDataProperties)

+ (NSFetchRequest<Teacher *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Teacher"];
}

@dynamic name;
@dynamic students;

@end
