// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to FriendsInfo.h instead.

#import <CoreData/CoreData.h>

extern const struct FriendsInfoAttributes {
	__unsafe_unretained NSString *firendage;
	__unsafe_unretained NSString *friendactivitynumber;
	__unsafe_unretained NSString *friendattentionnumber;
	__unsafe_unretained NSString *friendbirthday;
	__unsafe_unretained NSString *friendcreatetime;
	__unsafe_unretained NSString *frienddistance;
	__unsafe_unretained NSString *friendfansnumber;
	__unsafe_unretained NSString *friendfavoritesports;
	__unsafe_unretained NSString *friendflag;
	__unsafe_unretained NSString *friendheight;
	__unsafe_unretained NSString *friendid;
	__unsafe_unretained NSString *friendintroduce;
	__unsafe_unretained NSString *friendisattention;
	__unsafe_unretained NSString *friendname;
	__unsafe_unretained NSString *friendnickname;
	__unsafe_unretained NSString *friendphoto;
	__unsafe_unretained NSString *friendpoint;
	__unsafe_unretained NSString *friendpopularity;
	__unsafe_unretained NSString *friendsex;
	__unsafe_unretained NSString *friendstate;
	__unsafe_unretained NSString *friendtype;
	__unsafe_unretained NSString *friendweight;
} FriendsInfoAttributes;

extern const struct FriendsInfoRelationships {
	__unsafe_unretained NSString *activitytakein;
	__unsafe_unretained NSString *canstartplan;
	__unsafe_unretained NSString *finishplan;
	__unsafe_unretained NSString *friendattention;
	__unsafe_unretained NSString *friendfans;
	__unsafe_unretained NSString *healthplan;
	__unsafe_unretained NSString *popularityofuser;
	__unsafe_unretained NSString *teachofuser;
	__unsafe_unretained NSString *trendfavorite;
	__unsafe_unretained NSString *trendshared;
	__unsafe_unretained NSString *user;
	__unsafe_unretained NSString *useroffans;
	__unsafe_unretained NSString *userofnear;
} FriendsInfoRelationships;

@class Activity;
@class HealthPlan;
@class HealthPlan;
@class FriendsInfo;
@class FriendsInfo;
@class HealthPlan;
@class UserInfo;
@class UserInfo;
@class Trends;
@class Trends;
@class UserInfo;
@class UserInfo;
@class UserInfo;

@interface FriendsInfoID : NSManagedObjectID {}
@end

@interface _FriendsInfo : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) FriendsInfoID* objectID;

@property (nonatomic, strong) NSNumber* firendage;

@property (atomic) int16_t firendageValue;
- (int16_t)firendageValue;
- (void)setFirendageValue:(int16_t)value_;

//- (BOOL)validateFirendage:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* friendactivitynumber;

//- (BOOL)validateFriendactivitynumber:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* friendattentionnumber;

//- (BOOL)validateFriendattentionnumber:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* friendbirthday;

//- (BOOL)validateFriendbirthday:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* friendcreatetime;

//- (BOOL)validateFriendcreatetime:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* frienddistance;

@property (atomic) float frienddistanceValue;
- (float)frienddistanceValue;
- (void)setFrienddistanceValue:(float)value_;

//- (BOOL)validateFrienddistance:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* friendfansnumber;

@property (atomic) int16_t friendfansnumberValue;
- (int16_t)friendfansnumberValue;
- (void)setFriendfansnumberValue:(int16_t)value_;

//- (BOOL)validateFriendfansnumber:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* friendfavoritesports;

//- (BOOL)validateFriendfavoritesports:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* friendflag;

//- (BOOL)validateFriendflag:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* friendheight;

//- (BOOL)validateFriendheight:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* friendid;

//- (BOOL)validateFriendid:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* friendintroduce;

//- (BOOL)validateFriendintroduce:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* friendisattention;

//- (BOOL)validateFriendisattention:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* friendname;

//- (BOOL)validateFriendname:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* friendnickname;

//- (BOOL)validateFriendnickname:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* friendphoto;

//- (BOOL)validateFriendphoto:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* friendpoint;

//- (BOOL)validateFriendpoint:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* friendpopularity;

//- (BOOL)validateFriendpopularity:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* friendsex;

//- (BOOL)validateFriendsex:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* friendstate;

//- (BOOL)validateFriendstate:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* friendtype;

//- (BOOL)validateFriendtype:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* friendweight;

//- (BOOL)validateFriendweight:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) Activity *activitytakein;

//- (BOOL)validateActivitytakein:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSSet *canstartplan;

- (NSMutableSet*)canstartplanSet;

@property (nonatomic, strong) NSSet *finishplan;

- (NSMutableSet*)finishplanSet;

@property (nonatomic, strong) NSSet *friendattention;

- (NSMutableSet*)friendattentionSet;

@property (nonatomic, strong) NSSet *friendfans;

- (NSMutableSet*)friendfansSet;

@property (nonatomic, strong) HealthPlan *healthplan;

//- (BOOL)validateHealthplan:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) UserInfo *popularityofuser;

//- (BOOL)validatePopularityofuser:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) UserInfo *teachofuser;

//- (BOOL)validateTeachofuser:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) Trends *trendfavorite;

//- (BOOL)validateTrendfavorite:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) Trends *trendshared;

//- (BOOL)validateTrendshared:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) UserInfo *user;

//- (BOOL)validateUser:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) UserInfo *useroffans;

//- (BOOL)validateUseroffans:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) UserInfo *userofnear;

//- (BOOL)validateUserofnear:(id*)value_ error:(NSError**)error_;

@end

@interface _FriendsInfo (CanstartplanCoreDataGeneratedAccessors)
- (void)addCanstartplan:(NSSet*)value_;
- (void)removeCanstartplan:(NSSet*)value_;
- (void)addCanstartplanObject:(HealthPlan*)value_;
- (void)removeCanstartplanObject:(HealthPlan*)value_;

@end

@interface _FriendsInfo (FinishplanCoreDataGeneratedAccessors)
- (void)addFinishplan:(NSSet*)value_;
- (void)removeFinishplan:(NSSet*)value_;
- (void)addFinishplanObject:(HealthPlan*)value_;
- (void)removeFinishplanObject:(HealthPlan*)value_;

@end

@interface _FriendsInfo (FriendattentionCoreDataGeneratedAccessors)
- (void)addFriendattention:(NSSet*)value_;
- (void)removeFriendattention:(NSSet*)value_;
- (void)addFriendattentionObject:(FriendsInfo*)value_;
- (void)removeFriendattentionObject:(FriendsInfo*)value_;

@end

@interface _FriendsInfo (FriendfansCoreDataGeneratedAccessors)
- (void)addFriendfans:(NSSet*)value_;
- (void)removeFriendfans:(NSSet*)value_;
- (void)addFriendfansObject:(FriendsInfo*)value_;
- (void)removeFriendfansObject:(FriendsInfo*)value_;

@end

@interface _FriendsInfo (CoreDataGeneratedPrimitiveAccessors)

- (NSNumber*)primitiveFirendage;
- (void)setPrimitiveFirendage:(NSNumber*)value;

- (int16_t)primitiveFirendageValue;
- (void)setPrimitiveFirendageValue:(int16_t)value_;

- (NSString*)primitiveFriendactivitynumber;
- (void)setPrimitiveFriendactivitynumber:(NSString*)value;

- (NSString*)primitiveFriendattentionnumber;
- (void)setPrimitiveFriendattentionnumber:(NSString*)value;

- (NSString*)primitiveFriendbirthday;
- (void)setPrimitiveFriendbirthday:(NSString*)value;

- (NSString*)primitiveFriendcreatetime;
- (void)setPrimitiveFriendcreatetime:(NSString*)value;

- (NSNumber*)primitiveFrienddistance;
- (void)setPrimitiveFrienddistance:(NSNumber*)value;

- (float)primitiveFrienddistanceValue;
- (void)setPrimitiveFrienddistanceValue:(float)value_;

- (NSNumber*)primitiveFriendfansnumber;
- (void)setPrimitiveFriendfansnumber:(NSNumber*)value;

- (int16_t)primitiveFriendfansnumberValue;
- (void)setPrimitiveFriendfansnumberValue:(int16_t)value_;

- (NSString*)primitiveFriendfavoritesports;
- (void)setPrimitiveFriendfavoritesports:(NSString*)value;

- (NSString*)primitiveFriendflag;
- (void)setPrimitiveFriendflag:(NSString*)value;

- (NSString*)primitiveFriendheight;
- (void)setPrimitiveFriendheight:(NSString*)value;

- (NSString*)primitiveFriendid;
- (void)setPrimitiveFriendid:(NSString*)value;

- (NSString*)primitiveFriendintroduce;
- (void)setPrimitiveFriendintroduce:(NSString*)value;

- (NSString*)primitiveFriendisattention;
- (void)setPrimitiveFriendisattention:(NSString*)value;

- (NSString*)primitiveFriendname;
- (void)setPrimitiveFriendname:(NSString*)value;

- (NSString*)primitiveFriendnickname;
- (void)setPrimitiveFriendnickname:(NSString*)value;

- (NSString*)primitiveFriendphoto;
- (void)setPrimitiveFriendphoto:(NSString*)value;

- (NSString*)primitiveFriendpoint;
- (void)setPrimitiveFriendpoint:(NSString*)value;

- (NSString*)primitiveFriendpopularity;
- (void)setPrimitiveFriendpopularity:(NSString*)value;

- (NSString*)primitiveFriendsex;
- (void)setPrimitiveFriendsex:(NSString*)value;

- (NSString*)primitiveFriendstate;
- (void)setPrimitiveFriendstate:(NSString*)value;

- (NSString*)primitiveFriendtype;
- (void)setPrimitiveFriendtype:(NSString*)value;

- (NSString*)primitiveFriendweight;
- (void)setPrimitiveFriendweight:(NSString*)value;

- (Activity*)primitiveActivitytakein;
- (void)setPrimitiveActivitytakein:(Activity*)value;

- (NSMutableSet*)primitiveCanstartplan;
- (void)setPrimitiveCanstartplan:(NSMutableSet*)value;

- (NSMutableSet*)primitiveFinishplan;
- (void)setPrimitiveFinishplan:(NSMutableSet*)value;

- (NSMutableSet*)primitiveFriendattention;
- (void)setPrimitiveFriendattention:(NSMutableSet*)value;

- (NSMutableSet*)primitiveFriendfans;
- (void)setPrimitiveFriendfans:(NSMutableSet*)value;

- (HealthPlan*)primitiveHealthplan;
- (void)setPrimitiveHealthplan:(HealthPlan*)value;

- (UserInfo*)primitivePopularityofuser;
- (void)setPrimitivePopularityofuser:(UserInfo*)value;

- (UserInfo*)primitiveTeachofuser;
- (void)setPrimitiveTeachofuser:(UserInfo*)value;

- (Trends*)primitiveTrendfavorite;
- (void)setPrimitiveTrendfavorite:(Trends*)value;

- (Trends*)primitiveTrendshared;
- (void)setPrimitiveTrendshared:(Trends*)value;

- (UserInfo*)primitiveUser;
- (void)setPrimitiveUser:(UserInfo*)value;

- (UserInfo*)primitiveUseroffans;
- (void)setPrimitiveUseroffans:(UserInfo*)value;

- (UserInfo*)primitiveUserofnear;
- (void)setPrimitiveUserofnear:(UserInfo*)value;

@end
