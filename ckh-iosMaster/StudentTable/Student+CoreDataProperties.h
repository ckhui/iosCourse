//
//  Student+CoreDataProperties.h
//  StudentTable
//
//  Created by NEXTAcademy on 11/3/16.
//  Copyright © 2016 ckhui. All rights reserved.
//

#import "Student+CoreDataClass.h"

@class Teacher;
NS_ASSUME_NONNULL_BEGIN

@interface Student (CoreDataProperties)

+ (NSFetchRequest<Student *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *name;
@property (nonatomic) int16_t age;
@property (nullable, nonatomic, copy) NSDecimalNumber *gpa;
@property (nullable, nonatomic, retain) Teacher *teacher;

@end

NS_ASSUME_NONNULL_END
