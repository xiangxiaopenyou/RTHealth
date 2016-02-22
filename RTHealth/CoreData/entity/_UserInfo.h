// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to UserInfo.h instead.

#import <CoreData/CoreData.h>

extern const struct UserInfoAttributes {
	__unsafe_unretained NSString *isnewuser;
	__unsafe_unretained NSString *useractivitynumber;
	__unsafe_unretained NSString *userattentionnumber;
	__unsafe_unretained NSString *userbirthday;
	__unsafe_unretained NSString *userfansnumber;
	__unsafe_unretained NSString *userfavoritesports;
	__unsafe_unretained NSString *usergeopoint;
	__unsafe_unretained NSString *userheight;
	__unsafe_unretained NSString *userheightpublic;
	__unsafe_unretained NSString *userid;
	__unsafe_unretained NSString *userintroduce;
	__unsafe_unretained NSString *username;
	__unsafe_unretained NSString *usernickname;
	__unsafe_unretained NSString *userphoto;
	__unsafe_unretained NSString *userpoint;
	__unsafe_unretained NSString *usersex;
	__unsafe_unretained NSString *usertoken;
	__unsafe_unretained NSString *userweight;
	__unsafe_unretained NSString *userweightpublic;
} UserInfoAttributes;

extern const struct UserInfoRelationships {
	__unsafe_unretained NSString *activity;
	__unsafe_unretained NSString *activitydetail;
	__unsafe_unretained NSString *activityrecommend;
	__unsafe_unretained NSString *addactivitydistance;
	__unsafe_unretained NSString *addactivitytime;
	__unsafe_unretained NSString *alltrends;
	__unsafe_unretained NSString *attentionuser;
	__unsafe_unretained NSString *canstartplan;
	__unsafe_unretained NSString *chat;
	__unsafe_unretained NSString *fansofmy;
	__unsafe_unretained NSString *finishedactivity;
	__unsafe_unretained NSString *finishedplan;
	__unsafe_unretained NSString *friendfinishedactivity;
	__unsafe_unretained NSString *friendtrends;
	__unsafe_unretained NSString *friendunderwayactivity;
	__unsafe_unretained NSString *healthplan;
	__unsafe_unretained NSString *importplanrenqi;
	__unsafe_unretained NSString *importplantime;
	__unsafe_unretained NSString *liketrends;
	__unsafe_unretained NSString *nearbyuser;
	__unsafe_unretained NSString *popularityuser;
	__unsafe_unretained NSString *praise;
	__unsafe_unretained NSString *remind;
	__unsafe_unretained NSString *reply;
	__unsafe_unretained NSString *sportstrends;
	__unsafe_unretained NSString *systemmessage;
	__unsafe_unretained NSString *systemplan;
	__unsafe_unretained NSString *teacheruser;
	__unsafe_unretained NSString *underwayactivity;
	__unsafe_unretained NSString *usertopic;
	__unsafe_unretained NSString *usertrends;
} UserInfoRelationships;

@class Activity;
@class Activity;
@class Activity;
@class Activity;
@class Activity;
@class Trends;
@class FriendsInfo;
@class HealthPlan;
@class Chat;
@class FriendsInfo;
@class Activity;
@class HealthPlan;
@class Activity;
@class Trends;
@class Activity;
@class HealthPlan;
@class HealthPlan;
@class HealthPlan;
@class Trends;
@class FriendsInfo;
@class FriendsInfo;
@class Praise;
@class Remind;
@class Reply;
@class Trends;
@class SystemMessage;
@class HealthPlan;
@class FriendsInfo;
@class Activity;
@class Activity;
@class Trends;

@interface UserInfoID : NSManagedObjectID {}
@end

@interface _UserInfo : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) UserInfoID* objectID;

@property (nonatomic, strong) NSString* isnewuser;

//- (BOOL)validateIsnewuser:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* useractivitynumber;

//- (BOOL)validateUseractivitynumber:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* userattentionnumber;

//- (BOOL)validateUserattentionnumber:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* userbirthday;

//- (BOOL)validateUserbirthday:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* userfansnumber;

//- (BOOL)validateUserfansnumber:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* userfavoritesports;

//- (BOOL)validateUserfavoritesports:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* usergeopoint;

//- (BOOL)validateUsergeopoint:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* userheight;

//- (BOOL)validateUserheight:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* userheightpublic;

@property (atomic) BOOL userheightpublicValue;
- (BOOL)userheightpublicValue;
- (void)setUserheightpublicValue:(BOOL)value_;

//- (BOOL)validateUserheightpublic:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* userid;

//- (BOOL)validateUserid:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* userintroduce;

//- (BOOL)validateUserintroduce:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* username;

//- (BOOL)validateUsername:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* usernickname;

//- (BOOL)validateUsernickname:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* userphoto;

//- (BOOL)validateUserphoto:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* userpoint;

//- (BOOL)validateUserpoint:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* usersex;

//- (BOOL)validateUsersex:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* usertoken;

//- (BOOL)validateUsertoken:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* userweight;

//- (BOOL)validateUserweight:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* userweightpublic;

@property (atomic) BOOL userweightpublicValue;
- (BOOL)userweightpublicValue;
- (void)setUserweightpublicValue:(BOOL)value_;

//- (BOOL)validateUserweightpublic:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSSet *activity;

- (NSMutableSet*)activitySet;

@property (nonatomic, strong) Activity *activitydetail;

//- (BOOL)validateActivitydetail:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSSet *activityrecommend;

- (NSMutableSet*)activityrecommendSet;

@property (nonatomic, strong) NSSet *addactivitydistance;

- (NSMutableSet*)addactivitydistanceSet;

@property (nonatomic, strong) NSSet *addactivitytime;

- (NSMutableSet*)addactivitytimeSet;

@property (nonatomic, strong) NSSet *alltrends;

- (NSMutableSet*)alltrendsSet;

@property (nonatomic, strong) NSSet *attentionuser;

- (NSMutableSet*)attentionuserSet;

@property (nonatomic, strong) NSSet *canstartplan;

- (NSMutableSet*)canstartplanSet;

@property (nonatomic, strong) NSSet *chat;

- (NSMutableSet*)chatSet;

@property (nonatomic, strong) NSSet *fansofmy;

- (NSMutableSet*)fansofmySet;

@property (nonatomic, strong) NSSet *finishedactivity;

- (NSMutableSet*)finishedactivitySet;

@property (nonatomic, strong) NSSet *finishedplan;

- (NSMutableSet*)finishedplanSet;

@property (nonatomic, strong) NSSet *friendfinishedactivity;

- (NSMutableSet*)friendfinishedactivitySet;

@property (nonatomic, strong) NSSet *friendtrends;

- (NSMutableSet*)friendtrendsSet;

@property (nonatomic, strong) NSSet *friendunderwayactivity;

- (NSMutableSet*)friendunderwayactivitySet;

@property (nonatomic, strong) HealthPlan *healthplan;

//- (BOOL)validateHealthplan:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSSet *importplanrenqi;

- (NSMutableSet*)importplanrenqiSet;

@property (nonatomic, strong) NSSet *importplantime;

- (NSMutableSet*)importplantimeSet;

@property (nonatomic, strong) NSSet *liketrends;

- (NSMutableSet*)liketrendsSet;

@property (nonatomic, strong) NSSet *nearbyuser;

- (NSMutableSet*)nearbyuserSet;

@property (nonatomic, strong) NSSet *popularityuser;

- (NSMutableSet*)popularityuserSet;

@property (nonatomic, strong) NSSet *praise;

- (NSMutableSet*)praiseSet;

@property (nonatomic, strong) NSSet *remind;

- (NSMutableSet*)remindSet;

@property (nonatomic, strong) NSSet *reply;

- (NSMutableSet*)replySet;

@property (nonatomic, strong) NSSet *sportstrends;

- (NSMutableSet*)sportstrendsSet;

@property (nonatomic, strong) NSSet *systemmessage;

- (NSMutableSet*)systemmessageSet;

@property (nonatomic, strong) NSSet *systemplan;

- (NSMutableSet*)systemplanSet;

@property (nonatomic, strong) NSSet *teacheruser;

- (NSMutableSet*)teacheruserSet;

@property (nonatomic, strong) NSSet *underwayactivity;

- (NSMutableSet*)underwayactivitySet;

@property (nonatomic, strong) NSSet *usertopic;

- (NSMutableSet*)usertopicSet;

@property (nonatomic, strong) NSSet *usertrends;

- (NSMutableSet*)usertrendsSet;

@end

@interface _UserInfo (ActivityCoreDataGeneratedAccessors)
- (void)addActivity:(NSSet*)value_;
- (void)removeActivity:(NSSet*)value_;
- (void)addActivityObject:(Activity*)value_;
- (void)removeActivityObject:(Activity*)value_;

@end

@interface _UserInfo (ActivityrecommendCoreDataGeneratedAccessors)
- (void)addActivityrecommend:(NSSet*)value_;
- (void)removeActivityrecommend:(NSSet*)value_;
- (void)addActivityrecommendObject:(Activity*)value_;
- (void)removeActivityrecommendObject:(Activity*)value_;

@end

@interface _UserInfo (AddactivitydistanceCoreDataGeneratedAccessors)
- (void)addAddactivitydistance:(NSSet*)value_;
- (void)removeAddactivitydistance:(NSSet*)value_;
- (void)addAddactivitydistanceObject:(Activity*)value_;
- (void)removeAddactivitydistanceObject:(Activity*)value_;

@end

@interface _UserInfo (AddactivitytimeCoreDataGeneratedAccessors)
- (void)addAddactivitytime:(NSSet*)value_;
- (void)removeAddactivitytime:(NSSet*)value_;
- (void)addAddactivitytimeObject:(Activity*)value_;
- (void)removeAddactivitytimeObject:(Activity*)value_;

@end

@interface _UserInfo (AlltrendsCoreDataGeneratedAccessors)
- (void)addAlltrends:(NSSet*)value_;
- (void)removeAlltrends:(NSSet*)value_;
- (void)addAlltrendsObject:(Trends*)value_;
- (void)removeAlltrendsObject:(Trends*)value_;

@end

@interface _UserInfo (AttentionuserCoreDataGeneratedAccessors)
- (void)addAttentionuser:(NSSet*)value_;
- (void)removeAttentionuser:(NSSet*)value_;
- (void)addAttentionuserObject:(FriendsInfo*)value_;
- (void)removeAttentionuserObject:(FriendsInfo*)value_;

@end

@interface _UserInfo (CanstartplanCoreDataGeneratedAccessors)
- (void)addCanstartplan:(NSSet*)value_;
- (void)removeCanstartplan:(NSSet*)value_;
- (void)addCanstartplanObject:(HealthPlan*)value_;
- (void)removeCanstartplanObject:(HealthPlan*)value_;

@end

@interface _UserInfo (ChatCoreDataGeneratedAccessors)
- (void)addChat:(NSSet*)value_;
- (void)removeChat:(NSSet*)value_;
- (void)addChatObject:(Chat*)value_;
- (void)removeChatObject:(Chat*)value_;

@end

@interface _UserInfo (FansofmyCoreDataGeneratedAccessors)
- (void)addFansofmy:(NSSet*)value_;
- (void)removeFansofmy:(NSSet*)value_;
- (void)addFansofmyObject:(FriendsInfo*)value_;
- (void)removeFansofmyObject:(FriendsInfo*)value_;

@end

@interface _UserInfo (FinishedactivityCoreDataGeneratedAccessors)
- (void)addFinishedactivity:(NSSet*)value_;
- (void)removeFinishedactivity:(NSSet*)value_;
- (void)addFinishedactivityObject:(Activity*)value_;
- (void)removeFinishedactivityObject:(Activity*)value_;

@end

@interface _UserInfo (FinishedplanCoreDataGeneratedAccessors)
- (void)addFinishedplan:(NSSet*)value_;
- (void)removeFinishedplan:(NSSet*)value_;
- (void)addFinishedplanObject:(HealthPlan*)value_;
- (void)removeFinishedplanObject:(HealthPlan*)value_;

@end

@interface _UserInfo (FriendfinishedactivityCoreDataGeneratedAccessors)
- (void)addFriendfinishedactivity:(NSSet*)value_;
- (void)removeFriendfinishedactivity:(NSSet*)value_;
- (void)addFriendfinishedactivityObject:(Activity*)value_;
- (void)removeFriendfinishedactivityObject:(Activity*)value_;

@end

@interface _UserInfo (FriendtrendsCoreDataGeneratedAccessors)
- (void)addFriendtrends:(NSSet*)value_;
- (void)removeFriendtrends:(NSSet*)value_;
- (void)addFriendtrendsObject:(Trends*)value_;
- (void)removeFriendtrendsObject:(Trends*)value_;

@end

@interface _UserInfo (FriendunderwayactivityCoreDataGeneratedAccessors)
- (void)addFriendunderwayactivity:(NSSet*)value_;
- (void)removeFriendunderwayactivity:(NSSet*)value_;
- (void)addFriendunderwayactivityObject:(Activity*)value_;
- (void)removeFriendunderwayactivityObject:(Activity*)value_;

@end

@interface _UserInfo (ImportplanrenqiCoreDataGeneratedAccessors)
- (void)addImportplanrenqi:(NSSet*)value_;
- (void)removeImportplanrenqi:(NSSet*)value_;
- (void)addImportplanrenqiObject:(HealthPlan*)value_;
- (void)removeImportplanrenqiObject:(HealthPlan*)value_;

@end

@interface _UserInfo (ImportplantimeCoreDataGeneratedAccessors)
- (void)addImportplantime:(NSSet*)value_;
- (void)removeImportplantime:(NSSet*)value_;
- (void)addImportplantimeObject:(HealthPlan*)value_;
- (void)removeImportplantimeObject:(HealthPlan*)value_;

@end

@interface _UserInfo (LiketrendsCoreDataGeneratedAccessors)
- (void)addLiketrends:(NSSet*)value_;
- (void)removeLiketrends:(NSSet*)value_;
- (void)addLiketrendsObject:(Trends*)value_;
- (void)removeLiketrendsObject:(Trends*)value_;

@end

@interface _UserInfo (NearbyuserCoreDataGeneratedAccessors)
- (void)addNearbyuser:(NSSet*)value_;
- (void)removeNearbyuser:(NSSet*)value_;
- (void)addNearbyuserObject:(FriendsInfo*)value_;
- (void)removeNearbyuserObject:(FriendsInfo*)value_;

@end

@interface _UserInfo (PopularityuserCoreDataGeneratedAccessors)
- (void)addPopularityuser:(NSSet*)value_;
- (void)removePopularityuser:(NSSet*)value_;
- (void)addPopularityuserObject:(FriendsInfo*)value_;
- (void)removePopularityuserObject:(FriendsInfo*)value_;

@end

@interface _UserInfo (PraiseCoreDataGeneratedAccessors)
- (void)addPraise:(NSSet*)value_;
- (void)removePraise:(NSSet*)value_;
- (void)addPraiseObject:(Praise*)value_;
- (void)removePraiseObject:(Praise*)value_;

@end

@interface _UserInfo (RemindCoreDataGeneratedAccessors)
- (void)addRemind:(NSSet*)value_;
- (void)removeRemind:(NSSet*)value_;
- (void)addRemindObject:(Remind*)value_;
- (void)removeRemindObject:(Remind*)value_;

@end

@interface _UserInfo (ReplyCoreDataGeneratedAccessors)
- (void)addReply:(NSSet*)value_;
- (void)removeReply:(NSSet*)value_;
- (void)addReplyObject:(Reply*)value_;
- (void)removeReplyObject:(Reply*)value_;

@end

@interface _UserInfo (SportstrendsCoreDataGeneratedAccessors)
- (void)addSportstrends:(NSSet*)value_;
- (void)removeSportstrends:(NSSet*)value_;
- (void)addSportstrendsObject:(Trends*)value_;
- (void)removeSportstrendsObject:(Trends*)value_;

@end

@interface _UserInfo (SystemmessageCoreDataGeneratedAccessors)
- (void)addSystemmessage:(NSSet*)value_;
- (void)removeSystemmessage:(NSSet*)value_;
- (void)addSystemmessageObject:(SystemMessage*)value_;
- (void)removeSystemmessageObject:(SystemMessage*)value_;

@end

@interface _UserInfo (SystemplanCoreDataGeneratedAccessors)
- (void)addSystemplan:(NSSet*)value_;
- (void)removeSystemplan:(NSSet*)value_;
- (void)addSystemplanObject:(HealthPlan*)value_;
- (void)removeSystemplanObject:(HealthPlan*)value_;

@end

@interface _UserInfo (TeacheruserCoreDataGeneratedAccessors)
- (void)addTeacheruser:(NSSet*)value_;
- (void)removeTeacheruser:(NSSet*)value_;
- (void)addTeacheruserObject:(FriendsInfo*)value_;
- (void)removeTeacheruserObject:(FriendsInfo*)value_;

@end

@interface _UserInfo (UnderwayactivityCoreDataGeneratedAccessors)
- (void)addUnderwayactivity:(NSSet*)value_;
- (void)removeUnderwayactivity:(NSSet*)value_;
- (void)addUnderwayactivityObject:(Activity*)value_;
- (void)removeUnderwayactivityObject:(Activity*)value_;

@end

@interface _UserInfo (UsertopicCoreDataGeneratedAccessors)
- (void)addUsertopic:(NSSet*)value_;
- (void)removeUsertopic:(NSSet*)value_;
- (void)addUsertopicObject:(Activity*)value_;
- (void)removeUsertopicObject:(Activity*)value_;

@end

@interface _UserInfo (UsertrendsCoreDataGeneratedAccessors)
- (void)addUsertrends:(NSSet*)value_;
- (void)removeUsertrends:(NSSet*)value_;
- (void)addUsertrendsObject:(Trends*)value_;
- (void)removeUsertrendsObject:(Trends*)value_;

@end

@interface _UserInfo (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveIsnewuser;
- (void)setPrimitiveIsnewuser:(NSString*)value;

- (NSString*)primitiveUseractivitynumber;
- (void)setPrimitiveUseractivitynumber:(NSString*)value;

- (NSString*)primitiveUserattentionnumber;
- (void)setPrimitiveUserattentionnumber:(NSString*)value;

- (NSString*)primitiveUserbirthday;
- (void)setPrimitiveUserbirthday:(NSString*)value;

- (NSString*)primitiveUserfansnumber;
- (void)setPrimitiveUserfansnumber:(NSString*)value;

- (NSString*)primitiveUserfavoritesports;
- (void)setPrimitiveUserfavoritesports:(NSString*)value;

- (NSString*)primitiveUsergeopoint;
- (void)setPrimitiveUsergeopoint:(NSString*)value;

- (NSString*)primitiveUserheight;
- (void)setPrimitiveUserheight:(NSString*)value;

- (NSNumber*)primitiveUserheightpublic;
- (void)setPrimitiveUserheightpublic:(NSNumber*)value;

- (BOOL)primitiveUserheightpublicValue;
- (void)setPrimitiveUserheightpublicValue:(BOOL)value_;

- (NSString*)primitiveUserid;
- (void)setPrimitiveUserid:(NSString*)value;

- (NSString*)primitiveUserintroduce;
- (void)setPrimitiveUserintroduce:(NSString*)value;

- (NSString*)primitiveUsername;
- (void)setPrimitiveUsername:(NSString*)value;

- (NSString*)primitiveUsernickname;
- (void)setPrimitiveUsernickname:(NSString*)value;

- (NSString*)primitiveUserphoto;
- (void)setPrimitiveUserphoto:(NSString*)value;

- (NSString*)primitiveUserpoint;
- (void)setPrimitiveUserpoint:(NSString*)value;

- (NSString*)primitiveUsersex;
- (void)setPrimitiveUsersex:(NSString*)value;

- (NSString*)primitiveUsertoken;
- (void)setPrimitiveUsertoken:(NSString*)value;

- (NSString*)primitiveUserweight;
- (void)setPrimitiveUserweight:(NSString*)value;

- (NSNumber*)primitiveUserweightpublic;
- (void)setPrimitiveUserweightpublic:(NSNumber*)value;

- (BOOL)primitiveUserweightpublicValue;
- (void)setPrimitiveUserweightpublicValue:(BOOL)value_;

- (NSMutableSet*)primitiveActivity;
- (void)setPrimitiveActivity:(NSMutableSet*)value;

- (Activity*)primitiveActivitydetail;
- (void)setPrimitiveActivitydetail:(Activity*)value;

- (NSMutableSet*)primitiveActivityrecommend;
- (void)setPrimitiveActivityrecommend:(NSMutableSet*)value;

- (NSMutableSet*)primitiveAddactivitydistance;
- (void)setPrimitiveAddactivitydistance:(NSMutableSet*)value;

- (NSMutableSet*)primitiveAddactivitytime;
- (void)setPrimitiveAddactivitytime:(NSMutableSet*)value;

- (NSMutableSet*)primitiveAlltrends;
- (void)setPrimitiveAlltrends:(NSMutableSet*)value;

- (NSMutableSet*)primitiveAttentionuser;
- (void)setPrimitiveAttentionuser:(NSMutableSet*)value;

- (NSMutableSet*)primitiveCanstartplan;
- (void)setPrimitiveCanstartplan:(NSMutableSet*)value;

- (NSMutableSet*)primitiveChat;
- (void)setPrimitiveChat:(NSMutableSet*)value;

- (NSMutableSet*)primitiveFansofmy;
- (void)setPrimitiveFansofmy:(NSMutableSet*)value;

- (NSMutableSet*)primitiveFinishedactivity;
- (void)setPrimitiveFinishedactivity:(NSMutableSet*)value;

- (NSMutableSet*)primitiveFinishedplan;
- (void)setPrimitiveFinishedplan:(NSMutableSet*)value;

- (NSMutableSet*)primitiveFriendfinishedactivity;
- (void)setPrimitiveFriendfinishedactivity:(NSMutableSet*)value;

- (NSMutableSet*)primitiveFriendtrends;
- (void)setPrimitiveFriendtrends:(NSMutableSet*)value;

- (NSMutableSet*)primitiveFriendunderwayactivity;
- (void)setPrimitiveFriendunderwayactivity:(NSMutableSet*)value;

- (HealthPlan*)primitiveHealthplan;
- (void)setPrimitiveHealthplan:(HealthPlan*)value;

- (NSMutableSet*)primitiveImportplanrenqi;
- (void)setPrimitiveImportplanrenqi:(NSMutableSet*)value;

- (NSMutableSet*)primitiveImportplantime;
- (void)setPrimitiveImportplantime:(NSMutableSet*)value;

- (NSMutableSet*)primitiveLiketrends;
- (void)setPrimitiveLiketrends:(NSMutableSet*)value;

- (NSMutableSet*)primitiveNearbyuser;
- (void)setPrimitiveNearbyuser:(NSMutableSet*)value;

- (NSMutableSet*)primitivePopularityuser;
- (void)setPrimitivePopularityuser:(NSMutableSet*)value;

- (NSMutableSet*)primitivePraise;
- (void)setPrimitivePraise:(NSMutableSet*)value;

- (NSMutableSet*)primitiveRemind;
- (void)setPrimitiveRemind:(NSMutableSet*)value;

- (NSMutableSet*)primitiveReply;
- (void)setPrimitiveReply:(NSMutableSet*)value;

- (NSMutableSet*)primitiveSportstrends;
- (void)setPrimitiveSportstrends:(NSMutableSet*)value;

- (NSMutableSet*)primitiveSystemmessage;
- (void)setPrimitiveSystemmessage:(NSMutableSet*)value;

- (NSMutableSet*)primitiveSystemplan;
- (void)setPrimitiveSystemplan:(NSMutableSet*)value;

- (NSMutableSet*)primitiveTeacheruser;
- (void)setPrimitiveTeacheruser:(NSMutableSet*)value;

- (NSMutableSet*)primitiveUnderwayactivity;
- (void)setPrimitiveUnderwayactivity:(NSMutableSet*)value;

- (NSMutableSet*)primitiveUsertopic;
- (void)setPrimitiveUsertopic:(NSMutableSet*)value;

- (NSMutableSet*)primitiveUsertrends;
- (void)setPrimitiveUsertrends:(NSMutableSet*)value;

@end
