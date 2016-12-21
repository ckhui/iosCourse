//
//  Book+CoreDataProperties.h
//  bookface2
//
//  Created by NEXTAcademy on 11/4/16.
//  Copyright © 2016 ckhui. All rights reserved.
//

#import "Book+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Book (CoreDataProperties)

+ (NSFetchRequest<Book *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, retain) NSSet<Comment *> *hasComment;
@property (nullable, nonatomic, retain) NSSet<User *> *readBy;

@end

@interface Book (CoreDataGeneratedAccessors)

- (void)addHasCommentObject:(Comment *)value;
- (void)removeHasCommentObject:(Comment *)value;
- (void)addHasComment:(NSSet<Comment *> *)values;
- (void)removeHasComment:(NSSet<Comment *> *)values;

- (void)addReadByObject:(User *)value;
- (void)removeReadByObject:(User *)value;
- (void)addReadBy:(NSSet<User *> *)values;
- (void)removeReadBy:(NSSet<User *> *)values;

@end

NS_ASSUME_NONNULL_END
