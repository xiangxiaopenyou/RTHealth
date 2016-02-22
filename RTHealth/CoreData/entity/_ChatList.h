// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ChatList.h instead.

#import <CoreData/CoreData.h>

extern const struct ChatListAttributes {
	__unsafe_unretained NSString *chatcontent;
	__unsafe_unretained NSString *chatid;
	__unsafe_unretained NSString *chatisread;
	__unsafe_unretained NSString *chattime;
	__unsafe_unretained NSString *chattype;
} ChatListAttributes;

extern const struct ChatListRelationships {
	__unsafe_unretained NSString *chat;
} ChatListRelationships;

@class Chat;

@interface ChatListID : NSManagedObjectID {}
@end

@interface _ChatList : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) ChatListID* objectID;

@property (nonatomic, strong) NSString* chatcontent;

//- (BOOL)validateChatcontent:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* chatid;

//- (BOOL)validateChatid:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* chatisread;

//- (BOOL)validateChatisread:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* chattime;

//- (BOOL)validateChattime:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* chattype;

//- (BOOL)validateChattype:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) Chat *chat;

//- (BOOL)validateChat:(id*)value_ error:(NSError**)error_;

@end

@interface _ChatList (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveChatcontent;
- (void)setPrimitiveChatcontent:(NSString*)value;

- (NSString*)primitiveChatid;
- (void)setPrimitiveChatid:(NSString*)value;

- (NSString*)primitiveChatisread;
- (void)setPrimitiveChatisread:(NSString*)value;

- (NSString*)primitiveChattime;
- (void)setPrimitiveChattime:(NSString*)value;

- (NSString*)primitiveChattype;
- (void)setPrimitiveChattype:(NSString*)value;

- (Chat*)primitiveChat;
- (void)setPrimitiveChat:(Chat*)value;

@end
