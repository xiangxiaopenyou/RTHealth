// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to HealthPlan.h instead.

#import <CoreData/CoreData.h>

extern const struct HealthPlanAttributes {
	__unsafe_unretained NSString *planbegindate;
	__unsafe_unretained NSString *plancontent;
	__unsafe_unretained NSString *plancreatetime;
	__unsafe_unretained NSString *plancreateuserid;
	__unsafe_unretained NSString *plancycleday;
	__unsafe_unretained NSString *plancyclenumber;
	__unsafe_unretained NSString *planflag;
	__unsafe_unretained NSString *planid;
	__unsafe_unretained NSString *planimported;
	__unsafe_unretained NSString *planlevel;
	__unsafe_unretained NSString *plannumber;
	__unsafe_unretained NSString *planpublic;
	__unsafe_unretained NSString *planstate;
	__unsafe_unretained NSString *plantitle;
	__unsafe_unretained NSString *plantype;
} HealthPlanAttributes;

extern const struct HealthPlanRelationships {
	__unsafe_unretained NSString *finishedplanuser;
	__unsafe_unretained NSString *friend;
	__unsafe_unretained NSString *friendfinishplan;
	__unsafe_unretained NSString *friendstartplan;
	__unsafe_unretained NSString *smallhealthplan;
	__unsafe_unretained NSString *user;
	__unsafe_unretained NSString *usertoimportplanrenqi;
	__unsafe_unretained NSString *usertoimportplantime;
	__unsafe_unretained NSString *usertootherplan;
	__unsafe_unretained NSString *usertosystemplan;
} HealthPlanRelationships;

@class UserInfo;
@class FriendsInfo;
@class FriendsInfo;
@class FriendsInfo;
@class SmallHealthPlan;
@class UserInfo;
@class UserInfo;
@class UserInfo;
@class UserInfo;
@class UserInfo;

@interface HealthPlanID : NSManagedObjectID {}
@end

@interface _HealthPlan : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) HealthPlanID* objectID;

@property (nonatomic, strong) NSDate* planbegindate;

//- (BOOL)validatePlanbegindate:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* plancontent;

//- (BOOL)validatePlancontent:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* plancreatetime;

//- (BOOL)validatePlancreatetime:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* plancreateuserid;

//- (BOOL)validatePlancreateuserid:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* plancycleday;

@property (atomic) int16_t plancycledayValue;
- (int16_t)plancycledayValue;
- (void)setPlancycledayValue:(int16_t)value_;

//- (BOOL)validatePlancycleday:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* plancyclenumber;

@property (atomic) int16_t plancyclenumberValue;
- (int16_t)plancyclenumberValue;
- (void)setPlancyclenumberValue:(int16_t)value_;

//- (BOOL)validatePlancyclenumber:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* planflag;

//- (BOOL)validatePlanflag:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* planid;

//- (BOOL)validatePlanid:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* planimported;

//- (BOOL)validatePlanimported:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* planlevel;

//- (BOOL)validatePlanlevel:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* plannumber;

@property (atomic) int16_t plannumberValue;
- (int16_t)plannumberValue;
- (void)setPlannumberValue:(int16_t)value_;

//- (BOOL)validatePlannumber:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* planpublic;

//- (BOOL)validatePlanpublic:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* planstate;

//- (BOOL)validatePlanstate:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* plantitle;

//- (BOOL)validatePlantitle:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* plantype;

//- (BOOL)validatePlantype:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) UserInfo *finishedplanuser;

//- (BOOL)validateFinishedplanuser:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) FriendsInfo *friend;

//- (BOOL)validateFriend:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) FriendsInfo *friendfinishplan;

//- (BOOL)validateFriendfinishplan:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) FriendsInfo *friendstartplan;

//- (BOOL)validateFriendstartplan:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSSet *smallhealthplan;

- (NSMutableSet*)smallhealthplanSet;

@property (nonatomic, strong) UserInfo *user;

//- (BOOL)validateUser:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) UserInfo *usertoimportplanrenqi;

//- (BOOL)validateUsertoimportplanrenqi:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) UserInfo *usertoimportplantime;

//- (BOOL)validateUsertoimportplantime:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) UserInfo *usertootherplan;

//- (BOOL)validateUsertootherplan:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) UserInfo *usertosystemplan;

//- (BOOL)validateUsertosystemplan:(id*)value_ error:(NSError**)error_;

@end

@interface _HealthPlan (SmallhealthplanCoreDataGeneratedAccessors)
- (void)addSmallhealthplan:(NSSet*)value_;
- (void)removeSmallhealthplan:(NSSet*)value_;
- (void)addSmallhealthplanObject:(SmallHealthPlan*)value_;
- (void)removeSmallhealthplanObject:(SmallHealthPlan*)value_;

@end

@interface _HealthPlan (CoreDataGeneratedPrimitiveAccessors)

- (NSDate*)primitivePlanbegindate;
- (void)setPrimitivePlanbegindate:(NSDate*)value;

- (NSString*)primitivePlancontent;
- (void)setPrimitivePlancontent:(NSString*)value;

- (NSString*)primitivePlancreatetime;
- (void)setPrimitivePlancreatetime:(NSString*)value;

- (NSString*)primitivePlancreateuserid;
- (void)setPrimitivePlancreateuserid:(NSString*)value;

- (NSNumber*)primitivePlancycleday;
- (void)setPrimitivePlancycleday:(NSNumber*)value;

- (int16_t)primitivePlancycledayValue;
- (void)setPrimitivePlancycledayValue:(int16_t)value_;

- (NSNumber*)primitivePlancyclenumber;
- (void)setPrimitivePlancyclenumber:(NSNumber*)value;

- (int16_t)primitivePlancyclenumberValue;
- (void)setPrimitivePlancyclenumberValue:(int16_t)value_;

- (NSString*)primitivePlanflag;
- (void)setPrimitivePlanflag:(NSString*)value;

- (NSString*)primitivePlanid;
- (void)setPrimitivePlanid:(NSString*)value;

- (NSString*)primitivePlanimported;
- (void)setPrimitivePlanimported:(NSString*)value;

- (NSString*)primitivePlanlevel;
- (void)setPrimitivePlanlevel:(NSString*)value;

- (NSNumber*)primitivePlannumber;
- (void)setPrimitivePlannumber:(NSNumber*)value;

- (int16_t)primitivePlannumberValue;
- (void)setPrimitivePlannumberValue:(int16_t)value_;

- (NSString*)primitivePlanpublic;
- (void)setPrimitivePlanpublic:(NSString*)value;

- (NSString*)primitivePlanstate;
- (void)setPrimitivePlanstate:(NSString*)value;

- (NSString*)primitivePlantitle;
- (void)setPrimitivePlantitle:(NSString*)value;

- (NSString*)primitivePlantype;
- (void)setPrimitivePlantype:(NSString*)value;

- (UserInfo*)primitiveFinishedplanuser;
- (void)setPrimitiveFinishedplanuser:(UserInfo*)value;

- (FriendsInfo*)primitiveFriend;
- (void)setPrimitiveFriend:(FriendsInfo*)value;

- (FriendsInfo*)primitiveFriendfinishplan;
- (void)setPrimitiveFriendfinishplan:(FriendsInfo*)value;

- (FriendsInfo*)primitiveFriendstartplan;
- (void)setPrimitiveFriendstartplan:(FriendsInfo*)value;

- (NSMutableSet*)primitiveSmallhealthplan;
- (void)setPrimitiveSmallhealthplan:(NSMutableSet*)value;

- (UserInfo*)primitiveUser;
- (void)setPrimitiveUser:(UserInfo*)value;

- (UserInfo*)primitiveUsertoimportplanrenqi;
- (void)setPrimitiveUsertoimportplanrenqi:(UserInfo*)value;

- (UserInfo*)primitiveUsertoimportplantime;
- (void)setPrimitiveUsertoimportplantime:(UserInfo*)value;

- (UserInfo*)primitiveUsertootherplan;
- (void)setPrimitiveUsertootherplan:(UserInfo*)value;

- (UserInfo*)primitiveUsertosystemplan;
- (void)setPrimitiveUsertosystemplan:(UserInfo*)value;

@end
