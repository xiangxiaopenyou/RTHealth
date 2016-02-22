// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Remind.h instead.

#import <CoreData/CoreData.h>

extern const struct RemindAttributes {
	__unsafe_unretained NSString *remindcontent;
	__unsafe_unretained NSString *remindid;
	__unsafe_unretained NSString *remindisread;
	__unsafe_unretained NSString *remindsomeid;
	__unsafe_unretained NSString *remindsometitle;
	__unsafe_unretained NSString *remindtime;
	__unsafe_unretained NSString *remindtype;
	__unsafe_unretained NSString *reminduserid;
	__unsafe_unretained NSString *remindusernickname;
} RemindAttributes;

extern const struct RemindRelationships {
	__unsafe_unretained NSString *user;
} RemindRelationships;

@class UserInfo;

@interface RemindID : NSManagedObjectID {}
@end

@interface _Remind : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) RemindID* objectID;

@property (nonatomic, strong) NSString* remindcontent;

//- (BOOL)validateRemindcontent:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* remindid;

//- (BOOL)validateRemindid:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* remindisread;

//- (BOOL)validateRemindisread:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* remindsomeid;

//- (BOOL)validateRemindsomeid:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* remindsometitle;

//- (BOOL)validateRemindsometitle:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* remindtime;

//- (BOOL)validateRemindtime:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* remindtype;

//- (BOOL)validateRemindtype:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* reminduserid;

//- (BOOL)validateReminduserid:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* remindusernickname;

//- (BOOL)validateRemindusernickname:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) UserInfo *user;

//- (BOOL)validateUser:(id*)value_ error:(NSError**)error_;

@end

@interface _Remind (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveRemindcontent;
- (void)setPrimitiveRemindcontent:(NSString*)value;

- (NSString*)primitiveRemindid;
- (void)setPrimitiveRemindid:(NSString*)value;

- (NSString*)primitiveRemindisread;
- (void)setPrimitiveRemindisread:(NSString*)value;

- (NSString*)primitiveRemindsomeid;
- (void)setPrimitiveRemindsomeid:(NSString*)value;

- (NSString*)primitiveRemindsometitle;
- (void)setPrimitiveRemindsometitle:(NSString*)value;

- (NSString*)primitiveRemindtime;
- (void)setPrimitiveRemindtime:(NSString*)value;

- (NSString*)primitiveRemindtype;
- (void)setPrimitiveRemindtype:(NSString*)value;

- (NSString*)primitiveReminduserid;
- (void)setPrimitiveReminduserid:(NSString*)value;

- (NSString*)primitiveRemindusernickname;
- (void)setPrimitiveRemindusernickname:(NSString*)value;

- (UserInfo*)primitiveUser;
- (void)setPrimitiveUser:(UserInfo*)value;

@end
