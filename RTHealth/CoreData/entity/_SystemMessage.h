// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SystemMessage.h instead.

#import <CoreData/CoreData.h>

extern const struct SystemMessageAttributes {
	__unsafe_unretained NSString *systemmessagecontent;
	__unsafe_unretained NSString *systemmessageid;
	__unsafe_unretained NSString *systemmessageisread;
	__unsafe_unretained NSString *systemmessagelink;
	__unsafe_unretained NSString *systemmessagephoto;
	__unsafe_unretained NSString *systemmessagetime;
	__unsafe_unretained NSString *systemmessagetopic;
	__unsafe_unretained NSString *systemmessagetype;
	__unsafe_unretained NSString *systemphoto;
} SystemMessageAttributes;

extern const struct SystemMessageRelationships {
	__unsafe_unretained NSString *user;
} SystemMessageRelationships;

@class UserInfo;

@interface SystemMessageID : NSManagedObjectID {}
@end

@interface _SystemMessage : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) SystemMessageID* objectID;

@property (nonatomic, strong) NSString* systemmessagecontent;

//- (BOOL)validateSystemmessagecontent:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* systemmessageid;

//- (BOOL)validateSystemmessageid:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* systemmessageisread;

//- (BOOL)validateSystemmessageisread:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* systemmessagelink;

//- (BOOL)validateSystemmessagelink:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* systemmessagephoto;

//- (BOOL)validateSystemmessagephoto:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* systemmessagetime;

//- (BOOL)validateSystemmessagetime:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* systemmessagetopic;

//- (BOOL)validateSystemmessagetopic:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* systemmessagetype;

//- (BOOL)validateSystemmessagetype:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* systemphoto;

//- (BOOL)validateSystemphoto:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) UserInfo *user;

//- (BOOL)validateUser:(id*)value_ error:(NSError**)error_;

@end

@interface _SystemMessage (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveSystemmessagecontent;
- (void)setPrimitiveSystemmessagecontent:(NSString*)value;

- (NSString*)primitiveSystemmessageid;
- (void)setPrimitiveSystemmessageid:(NSString*)value;

- (NSString*)primitiveSystemmessageisread;
- (void)setPrimitiveSystemmessageisread:(NSString*)value;

- (NSString*)primitiveSystemmessagelink;
- (void)setPrimitiveSystemmessagelink:(NSString*)value;

- (NSString*)primitiveSystemmessagephoto;
- (void)setPrimitiveSystemmessagephoto:(NSString*)value;

- (NSString*)primitiveSystemmessagetime;
- (void)setPrimitiveSystemmessagetime:(NSString*)value;

- (NSString*)primitiveSystemmessagetopic;
- (void)setPrimitiveSystemmessagetopic:(NSString*)value;

- (NSString*)primitiveSystemmessagetype;
- (void)setPrimitiveSystemmessagetype:(NSString*)value;

- (NSString*)primitiveSystemphoto;
- (void)setPrimitiveSystemphoto:(NSString*)value;

- (UserInfo*)primitiveUser;
- (void)setPrimitiveUser:(UserInfo*)value;

@end
