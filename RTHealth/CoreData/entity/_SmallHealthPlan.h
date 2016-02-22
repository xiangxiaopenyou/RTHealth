// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SmallHealthPlan.h instead.

#import <CoreData/CoreData.h>

extern const struct SmallHealthPlanAttributes {
	__unsafe_unretained NSString *smallplanbegintime;
	__unsafe_unretained NSString *smallplancontent;
	__unsafe_unretained NSString *smallplancost;
	__unsafe_unretained NSString *smallplancycle;
	__unsafe_unretained NSString *smallplanendtime;
	__unsafe_unretained NSString *smallplanid;
	__unsafe_unretained NSString *smallplanmark;
	__unsafe_unretained NSString *smallplansequence;
	__unsafe_unretained NSString *smallplanstateflag;
	__unsafe_unretained NSString *smallplantype;
} SmallHealthPlanAttributes;

extern const struct SmallHealthPlanRelationships {
	__unsafe_unretained NSString *healthplan;
} SmallHealthPlanRelationships;

@class HealthPlan;

@interface SmallHealthPlanID : NSManagedObjectID {}
@end

@interface _SmallHealthPlan : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) SmallHealthPlanID* objectID;

@property (nonatomic, strong) NSString* smallplanbegintime;

//- (BOOL)validateSmallplanbegintime:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* smallplancontent;

//- (BOOL)validateSmallplancontent:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* smallplancost;

//- (BOOL)validateSmallplancost:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* smallplancycle;

//- (BOOL)validateSmallplancycle:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* smallplanendtime;

//- (BOOL)validateSmallplanendtime:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* smallplanid;

//- (BOOL)validateSmallplanid:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* smallplanmark;

//- (BOOL)validateSmallplanmark:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* smallplansequence;

//- (BOOL)validateSmallplansequence:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* smallplanstateflag;

//- (BOOL)validateSmallplanstateflag:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* smallplantype;

//- (BOOL)validateSmallplantype:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) HealthPlan *healthplan;

//- (BOOL)validateHealthplan:(id*)value_ error:(NSError**)error_;

@end

@interface _SmallHealthPlan (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveSmallplanbegintime;
- (void)setPrimitiveSmallplanbegintime:(NSString*)value;

- (NSString*)primitiveSmallplancontent;
- (void)setPrimitiveSmallplancontent:(NSString*)value;

- (NSString*)primitiveSmallplancost;
- (void)setPrimitiveSmallplancost:(NSString*)value;

- (NSString*)primitiveSmallplancycle;
- (void)setPrimitiveSmallplancycle:(NSString*)value;

- (NSString*)primitiveSmallplanendtime;
- (void)setPrimitiveSmallplanendtime:(NSString*)value;

- (NSString*)primitiveSmallplanid;
- (void)setPrimitiveSmallplanid:(NSString*)value;

- (NSString*)primitiveSmallplanmark;
- (void)setPrimitiveSmallplanmark:(NSString*)value;

- (NSString*)primitiveSmallplansequence;
- (void)setPrimitiveSmallplansequence:(NSString*)value;

- (NSString*)primitiveSmallplanstateflag;
- (void)setPrimitiveSmallplanstateflag:(NSString*)value;

- (NSString*)primitiveSmallplantype;
- (void)setPrimitiveSmallplantype:(NSString*)value;

- (HealthPlan*)primitiveHealthplan;
- (void)setPrimitiveHealthplan:(HealthPlan*)value;

@end
