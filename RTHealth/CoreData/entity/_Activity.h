// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Activity.h instead.

#import <CoreData/CoreData.h>

extern const struct ActivityAttributes {
	__unsafe_unretained NSString *activitybegintime;
	__unsafe_unretained NSString *activitycontent;
	__unsafe_unretained NSString *activitycreatedtime;
	__unsafe_unretained NSString *activitydistance;
	__unsafe_unretained NSString *activityendtime;
	__unsafe_unretained NSString *activityid;
	__unsafe_unretained NSString *activitylimitnumber;
	__unsafe_unretained NSString *activitylimittime;
	__unsafe_unretained NSString *activitynumber;
	__unsafe_unretained NSString *activityownerid;
	__unsafe_unretained NSString *activityownernickname;
	__unsafe_unretained NSString *activityplace;
	__unsafe_unretained NSString *activityposition;
	__unsafe_unretained NSString *activitytelephone;
	__unsafe_unretained NSString *activitytitle;
	__unsafe_unretained NSString *positionlatitude;
	__unsafe_unretained NSString *positionlongitude;
} ActivityAttributes;

extern const struct ActivityRelationships {
	__unsafe_unretained NSString *detailofactivity;
	__unsafe_unretained NSString *finishedfriend;
	__unsafe_unretained NSString *finisheduser;
	__unsafe_unretained NSString *underwayfriend;
	__unsafe_unretained NSString *underwayuser;
	__unsafe_unretained NSString *useractivity;
	__unsafe_unretained NSString *useroftopic;
	__unsafe_unretained NSString *userrecommend;
	__unsafe_unretained NSString *usertakein;
	__unsafe_unretained NSString *usertoaddactivitydistance;
	__unsafe_unretained NSString *usertoaddactivitytime;
} ActivityRelationships;

@class UserInfo;
@class UserInfo;
@class UserInfo;
@class UserInfo;
@class UserInfo;
@class UserInfo;
@class UserInfo;
@class UserInfo;
@class FriendsInfo;
@class UserInfo;
@class UserInfo;

@interface ActivityID : NSManagedObjectID {}
@end

@interface _Activity : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) ActivityID* objectID;

@property (nonatomic, strong) NSString* activitybegintime;

//- (BOOL)validateActivitybegintime:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* activitycontent;

//- (BOOL)validateActivitycontent:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* activitycreatedtime;

//- (BOOL)validateActivitycreatedtime:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* activitydistance;

//- (BOOL)validateActivitydistance:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* activityendtime;

//- (BOOL)validateActivityendtime:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* activityid;

//- (BOOL)validateActivityid:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* activitylimitnumber;

//- (BOOL)validateActivitylimitnumber:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* activitylimittime;

//- (BOOL)validateActivitylimittime:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* activitynumber;

//- (BOOL)validateActivitynumber:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* activityownerid;

//- (BOOL)validateActivityownerid:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* activityownernickname;

//- (BOOL)validateActivityownernickname:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* activityplace;

//- (BOOL)validateActivityplace:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* activityposition;

//- (BOOL)validateActivityposition:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* activitytelephone;

//- (BOOL)validateActivitytelephone:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* activitytitle;

//- (BOOL)validateActivitytitle:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* positionlatitude;

//- (BOOL)validatePositionlatitude:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* positionlongitude;

//- (BOOL)validatePositionlongitude:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) UserInfo *detailofactivity;

//- (BOOL)validateDetailofactivity:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) UserInfo *finishedfriend;

//- (BOOL)validateFinishedfriend:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) UserInfo *finisheduser;

//- (BOOL)validateFinisheduser:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) UserInfo *underwayfriend;

//- (BOOL)validateUnderwayfriend:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) UserInfo *underwayuser;

//- (BOOL)validateUnderwayuser:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) UserInfo *useractivity;

//- (BOOL)validateUseractivity:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) UserInfo *useroftopic;

//- (BOOL)validateUseroftopic:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) UserInfo *userrecommend;

//- (BOOL)validateUserrecommend:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSSet *usertakein;

- (NSMutableSet*)usertakeinSet;

@property (nonatomic, strong) UserInfo *usertoaddactivitydistance;

//- (BOOL)validateUsertoaddactivitydistance:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) UserInfo *usertoaddactivitytime;

//- (BOOL)validateUsertoaddactivitytime:(id*)value_ error:(NSError**)error_;

@end

@interface _Activity (UsertakeinCoreDataGeneratedAccessors)
- (void)addUsertakein:(NSSet*)value_;
- (void)removeUsertakein:(NSSet*)value_;
- (void)addUsertakeinObject:(FriendsInfo*)value_;
- (void)removeUsertakeinObject:(FriendsInfo*)value_;

@end

@interface _Activity (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveActivitybegintime;
- (void)setPrimitiveActivitybegintime:(NSString*)value;

- (NSString*)primitiveActivitycontent;
- (void)setPrimitiveActivitycontent:(NSString*)value;

- (NSString*)primitiveActivitycreatedtime;
- (void)setPrimitiveActivitycreatedtime:(NSString*)value;

- (NSString*)primitiveActivitydistance;
- (void)setPrimitiveActivitydistance:(NSString*)value;

- (NSString*)primitiveActivityendtime;
- (void)setPrimitiveActivityendtime:(NSString*)value;

- (NSString*)primitiveActivityid;
- (void)setPrimitiveActivityid:(NSString*)value;

- (NSString*)primitiveActivitylimitnumber;
- (void)setPrimitiveActivitylimitnumber:(NSString*)value;

- (NSString*)primitiveActivitylimittime;
- (void)setPrimitiveActivitylimittime:(NSString*)value;

- (NSString*)primitiveActivitynumber;
- (void)setPrimitiveActivitynumber:(NSString*)value;

- (NSString*)primitiveActivityownerid;
- (void)setPrimitiveActivityownerid:(NSString*)value;

- (NSString*)primitiveActivityownernickname;
- (void)setPrimitiveActivityownernickname:(NSString*)value;

- (NSString*)primitiveActivityplace;
- (void)setPrimitiveActivityplace:(NSString*)value;

- (NSString*)primitiveActivityposition;
- (void)setPrimitiveActivityposition:(NSString*)value;

- (NSString*)primitiveActivitytelephone;
- (void)setPrimitiveActivitytelephone:(NSString*)value;

- (NSString*)primitiveActivitytitle;
- (void)setPrimitiveActivitytitle:(NSString*)value;

- (NSString*)primitivePositionlatitude;
- (void)setPrimitivePositionlatitude:(NSString*)value;

- (NSString*)primitivePositionlongitude;
- (void)setPrimitivePositionlongitude:(NSString*)value;

- (UserInfo*)primitiveDetailofactivity;
- (void)setPrimitiveDetailofactivity:(UserInfo*)value;

- (UserInfo*)primitiveFinishedfriend;
- (void)setPrimitiveFinishedfriend:(UserInfo*)value;

- (UserInfo*)primitiveFinisheduser;
- (void)setPrimitiveFinisheduser:(UserInfo*)value;

- (UserInfo*)primitiveUnderwayfriend;
- (void)setPrimitiveUnderwayfriend:(UserInfo*)value;

- (UserInfo*)primitiveUnderwayuser;
- (void)setPrimitiveUnderwayuser:(UserInfo*)value;

- (UserInfo*)primitiveUseractivity;
- (void)setPrimitiveUseractivity:(UserInfo*)value;

- (UserInfo*)primitiveUseroftopic;
- (void)setPrimitiveUseroftopic:(UserInfo*)value;

- (UserInfo*)primitiveUserrecommend;
- (void)setPrimitiveUserrecommend:(UserInfo*)value;

- (NSMutableSet*)primitiveUsertakein;
- (void)setPrimitiveUsertakein:(NSMutableSet*)value;

- (UserInfo*)primitiveUsertoaddactivitydistance;
- (void)setPrimitiveUsertoaddactivitydistance:(UserInfo*)value;

- (UserInfo*)primitiveUsertoaddactivitytime;
- (void)setPrimitiveUsertoaddactivitytime:(UserInfo*)value;

@end
