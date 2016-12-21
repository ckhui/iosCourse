//
//  Student+CoreDataProperties.m
//  StudentTable
//
//  Created by NEXTAcademy on 11/3/16.
//  Copyright © 2016 ckhui. All rights reserved.
//

#import "Student+CoreDataProperties.h"

@implementation Student (CoreDataProperties)

+ (NSFetchRequest<Student *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Student"];
}

@dynamic name;
@dynamic age;
@dynamic gpa;
@dynamic teacher;

@end
