// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Chat.h instead.

#import <CoreData/CoreData.h>

extern const struct ChatAttributes {
	__unsafe_unretained NSString *chatlastcontent;
	__unsafe_unretained NSString *chatlasttime;
	__unsafe_unretained NSString *chatuserid;
	__unsafe_unretained NSString *chatusernickname;
	__unsafe_unretained NSString *chatuserphoto;
} ChatAttributes;

extern const struct ChatRelationships {
	__unsafe_unretained NSString *chatlist;
	__unsafe_unretained NSString *user;
} ChatRelationships;

@class ChatList;
@class UserInfo;

@interface ChatID : NSManagedObjectID {}
@end

@interface _Chat : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) ChatID* objectID;

@property (nonatomic, strong) NSString* chatlastcontent;

//- (BOOL)validateChatlastcontent:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* chatlasttime;

//- (BOOL)validateChatlasttime:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* chatuserid;

//- (BOOL)validateChatuserid:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* chatusernickname;

//- (BOOL)validateChatusernickname:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* chatuserphoto;

//- (BOOL)validateChatuserphoto:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSSet *chatlist;

- (NSMutableSet*)chatlistSet;

@property (nonatomic, strong) UserInfo *user;

//- (BOOL)validateUser:(id*)value_ error:(NSError**)error_;

@end

@interface _Chat (ChatlistCoreDataGeneratedAccessors)
- (void)addChatlist:(NSSet*)value_;
- (void)removeChatlist:(NSSet*)value_;
- (void)addChatlistObject:(ChatList*)value_;
- (void)removeChatlistObject:(ChatList*)value_;

@end

@interface _Chat (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveChatlastcontent;
- (void)setPrimitiveChatlastcontent:(NSString*)value;

- (NSString*)primitiveChatlasttime;
- (void)setPrimitiveChatlasttime:(NSString*)value;

- (NSString*)primitiveChatuserid;
- (void)setPrimitiveChatuserid:(NSString*)value;

- (NSString*)primitiveChatusernickname;
- (void)setPrimitiveChatusernickname:(NSString*)value;

- (NSString*)primitiveChatuserphoto;
- (void)setPrimitiveChatuserphoto:(NSString*)value;

- (NSMutableSet*)primitiveChatlist;
- (void)setPrimitiveChatlist:(NSMutableSet*)value;

- (UserInfo*)primitiveUser;
- (void)setPrimitiveUser:(UserInfo*)value;

@end
