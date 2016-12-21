//
//  User+CoreDataProperties.h
//  bookface2
//
//  Created by NEXTAcademy on 11/4/16.
//  Copyright © 2016 ckhui. All rights reserved.
//

#import "User+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface User (CoreDataProperties)

+ (NSFetchRequest<User *> *)fetchRequest;

@property (nonatomic) BOOL isFriend;
@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, retain) NSSet<User *> *friend;
@property (nullable, nonatomic, retain) NSSet<User *> *friendOf;
@property (nullable, nonatomic, retain) NSSet<Book *> *read;

@end

@interface User (CoreDataGeneratedAccessors)

- (void)addFriendObject:(User *)value;
- (void)removeFriendObject:(User *)value;
- (void)addFriend:(NSSet<User *> *)values;
- (void)removeFriend:(NSSet<User *> *)values;

- (void)addFriendOfObject:(User *)value;
- (void)removeFriendOfObject:(User *)value;
- (void)addFriendOf:(NSSet<User *> *)values;
- (void)removeFriendOf:(NSSet<User *> *)values;

- (void)addReadObject:(Book *)value;
- (void)removeReadObject:(Book *)value;
- (void)addRead:(NSSet<Book *> *)values;
- (void)removeRead:(NSSet<Book *> *)values;

@end

NS_ASSUME_NONNULL_END
