//
//  Comment+CoreDataProperties.h
//  bookface2
//
//  Created by NEXTAcademy on 11/4/16.
//  Copyright © 2016 ckhui. All rights reserved.
//

#import "Comment+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Comment (CoreDataProperties)

+ (NSFetchRequest<Comment *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *comment;
@property (nullable, nonatomic, retain) Book *onBook;

@end

NS_ASSUME_NONNULL_END
