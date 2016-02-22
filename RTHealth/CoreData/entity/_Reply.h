// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Reply.h instead.

#import <CoreData/CoreData.h>

extern const struct ReplyAttributes {
	__unsafe_unretained NSString *replycontent;
	__unsafe_unretained NSString *replyforusercontent;
	__unsafe_unretained NSString *replyforuserid;
	__unsafe_unretained NSString *replyforusernickname;
	__unsafe_unretained NSString *replyfriendid;
	__unsafe_unretained NSString *replyfriendnickname;
	__unsafe_unretained NSString *replyfriendtpye;
	__unsafe_unretained NSString *replyid;
	__unsafe_unretained NSString *replyisread;
	__unsafe_unretained NSString *replytime;
	__unsafe_unretained NSString *replytype;
	__unsafe_unretained NSString *replyuserid;
	__unsafe_unretained NSString *replyusernickname;
	__unsafe_unretained NSString *replyuserphoto;
	__unsafe_unretained NSString *trendaddress;
	__unsafe_unretained NSString *trendcommentnumber;
	__unsafe_unretained NSString *trendcontent;
	__unsafe_unretained NSString *trendcreatetime;
	__unsafe_unretained NSString *trendid;
	__unsafe_unretained NSString *trendlabel;
	__unsafe_unretained NSString *trendlike;
	__unsafe_unretained NSString *trendlocat;
	__unsafe_unretained NSString *trendphoto;
	__unsafe_unretained NSString *trendsex;
	__unsafe_unretained NSString *trendtitle;
	__unsafe_unretained NSString *trenduserhead;
	__unsafe_unretained NSString *trenduserid;
	__unsafe_unretained NSString *trendusertype;
	__unsafe_unretained NSString *username;
} ReplyAttributes;

extern const struct ReplyRelationships {
	__unsafe_unretained NSString *user;
} ReplyRelationships;

@class UserInfo;

@interface ReplyID : NSManagedObjectID {}
@end

@interface _Reply : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) ReplyID* objectID;

@property (nonatomic, strong) NSString* replycontent;

//- (BOOL)validateReplycontent:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* replyforusercontent;

//- (BOOL)validateReplyforusercontent:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* replyforuserid;

//- (BOOL)validateReplyforuserid:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* replyforusernickname;

//- (BOOL)validateReplyforusernickname:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* replyfriendid;

//- (BOOL)validateReplyfriendid:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* replyfriendnickname;

//- (BOOL)validateReplyfriendnickname:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* replyfriendtpye;

//- (BOOL)validateReplyfriendtpye:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* replyid;

//- (BOOL)validateReplyid:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* replyisread;

//- (BOOL)validateReplyisread:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* replytime;

//- (BOOL)validateReplytime:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* replytype;

//- (BOOL)validateReplytype:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* replyuserid;

//- (BOOL)validateReplyuserid:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* replyusernickname;

//- (BOOL)validateReplyusernickname:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* replyuserphoto;

//- (BOOL)validateReplyuserphoto:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* trendaddress;

//- (BOOL)validateTrendaddress:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* trendcommentnumber;

//- (BOOL)validateTrendcommentnumber:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* trendcontent;

//- (BOOL)validateTrendcontent:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* trendcreatetime;

//- (BOOL)validateTrendcreatetime:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* trendid;

//- (BOOL)validateTrendid:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* trendlabel;

//- (BOOL)validateTrendlabel:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* trendlike;

//- (BOOL)validateTrendlike:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* trendlocat;

//- (BOOL)validateTrendlocat:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* trendphoto;

//- (BOOL)validateTrendphoto:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* trendsex;

//- (BOOL)validateTrendsex:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* trendtitle;

//- (BOOL)validateTrendtitle:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* trenduserhead;

//- (BOOL)validateTrenduserhead:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* trenduserid;

//- (BOOL)validateTrenduserid:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* trendusertype;

//- (BOOL)validateTrendusertype:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* username;

//- (BOOL)validateUsername:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) UserInfo *user;

//- (BOOL)validateUser:(id*)value_ error:(NSError**)error_;

@end

@interface _Reply (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveReplycontent;
- (void)setPrimitiveReplycontent:(NSString*)value;

- (NSString*)primitiveReplyforusercontent;
- (void)setPrimitiveReplyforusercontent:(NSString*)value;

- (NSString*)primitiveReplyforuserid;
- (void)setPrimitiveReplyforuserid:(NSString*)value;

- (NSString*)primitiveReplyforusernickname;
- (void)setPrimitiveReplyforusernickname:(NSString*)value;

- (NSString*)primitiveReplyfriendid;
- (void)setPrimitiveReplyfriendid:(NSString*)value;

- (NSString*)primitiveReplyfriendnickname;
- (void)setPrimitiveReplyfriendnickname:(NSString*)value;

- (NSString*)primitiveReplyfriendtpye;
- (void)setPrimitiveReplyfriendtpye:(NSString*)value;

- (NSString*)primitiveReplyid;
- (void)setPrimitiveReplyid:(NSString*)value;

- (NSString*)primitiveReplyisread;
- (void)setPrimitiveReplyisread:(NSString*)value;

- (NSString*)primitiveReplytime;
- (void)setPrimitiveReplytime:(NSString*)value;

- (NSString*)primitiveReplytype;
- (void)setPrimitiveReplytype:(NSString*)value;

- (NSString*)primitiveReplyuserid;
- (void)setPrimitiveReplyuserid:(NSString*)value;

- (NSString*)primitiveReplyusernickname;
- (void)setPrimitiveReplyusernickname:(NSString*)value;

- (NSString*)primitiveReplyuserphoto;
- (void)setPrimitiveReplyuserphoto:(NSString*)value;

- (NSString*)primitiveTrendaddress;
- (void)setPrimitiveTrendaddress:(NSString*)value;

- (NSString*)primitiveTrendcommentnumber;
- (void)setPrimitiveTrendcommentnumber:(NSString*)value;

- (NSString*)primitiveTrendcontent;
- (void)setPrimitiveTrendcontent:(NSString*)value;

- (NSString*)primitiveTrendcreatetime;
- (void)setPrimitiveTrendcreatetime:(NSString*)value;

- (NSString*)primitiveTrendid;
- (void)setPrimitiveTrendid:(NSString*)value;

- (NSString*)primitiveTrendlabel;
- (void)setPrimitiveTrendlabel:(NSString*)value;

- (NSString*)primitiveTrendlike;
- (void)setPrimitiveTrendlike:(NSString*)value;

- (NSString*)primitiveTrendlocat;
- (void)setPrimitiveTrendlocat:(NSString*)value;

- (NSString*)primitiveTrendphoto;
- (void)setPrimitiveTrendphoto:(NSString*)value;

- (NSString*)primitiveTrendsex;
- (void)setPrimitiveTrendsex:(NSString*)value;

- (NSString*)primitiveTrendtitle;
- (void)setPrimitiveTrendtitle:(NSString*)value;

- (NSString*)primitiveTrenduserhead;
- (void)setPrimitiveTrenduserhead:(NSString*)value;

- (NSString*)primitiveTrenduserid;
- (void)setPrimitiveTrenduserid:(NSString*)value;

- (NSString*)primitiveTrendusertype;
- (void)setPrimitiveTrendusertype:(NSString*)value;

- (NSString*)primitiveUsername;
- (void)setPrimitiveUsername:(NSString*)value;

- (UserInfo*)primitiveUser;
- (void)setPrimitiveUser:(UserInfo*)value;

@end
