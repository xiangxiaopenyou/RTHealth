// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to HealthPlan.m instead.

#import "_HealthPlan.h"

const struct HealthPlanAttributes HealthPlanAttributes = {
	.planbegindate = @"planbegindate",
	.plancontent = @"plancontent",
	.plancreatetime = @"plancreatetime",
	.plancreateuserid = @"plancreateuserid",
	.plancycleday = @"plancycleday",
	.plancyclenumber = @"plancyclenumber",
	.planflag = @"planflag",
	.planid = @"planid",
	.planimported = @"planimported",
	.planlevel = @"planlevel",
	.plannumber = @"plannumber",
	.planpublic = @"planpublic",
	.planstate = @"planstate",
	.plantitle = @"plantitle",
	.plantype = @"plantype",
};

const struct HealthPlanRelationships HealthPlanRelationships = {
	.finishedplanuser = @"finishedplanuser",
	.friend = @"friend",
	.friendfinishplan = @"friendfinishplan",
	.friendstartplan = @"friendstartplan",
	.smallhealthplan = @"smallhealthplan",
	.user = @"user",
	.usertoimportplanrenqi = @"usertoimportplanrenqi",
	.usertoimportplantime = @"usertoimportplantime",
	.usertootherplan = @"usertootherplan",
	.usertosystemplan = @"usertosystemplan",
};

@implementation HealthPlanID
@end

@implementation _HealthPlan

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"HealthPlan" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"HealthPlan";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"HealthPlan" inManagedObjectContext:moc_];
}

- (HealthPlanID*)objectID {
	return (HealthPlanID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"plancycledayValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"plancycleday"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"plancyclenumberValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"plancyclenumber"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"plannumberValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"plannumber"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}

@dynamic planbegindate;

@dynamic plancontent;

@dynamic plancreatetime;

@dynamic plancreateuserid;

@dynamic plancycleday;

- (int16_t)plancycledayValue {
	NSNumber *result = [self plancycleday];
	return [result shortValue];
}

- (void)setPlancycledayValue:(int16_t)value_ {
	[self setPlancycleday:[NSNumber numberWithShort:value_]];
}

- (int16_t)primitivePlancycledayValue {
	NSNumber *result = [self primitivePlancycleday];
	return [result shortValue];
}

- (void)setPrimitivePlancycledayValue:(int16_t)value_ {
	[self setPrimitivePlancycleday:[NSNumber numberWithShort:value_]];
}

@dynamic plancyclenumber;

- (int16_t)plancyclenumberValue {
	NSNumber *result = [self plancyclenumber];
	return [result shortValue];
}

- (void)setPlancyclenumberValue:(int16_t)value_ {
	[self setPlancyclenumber:[NSNumber numberWithShort:value_]];
}

- (int16_t)primitivePlancyclenumberValue {
	NSNumber *result = [self primitivePlancyclenumber];
	return [result shortValue];
}

- (void)setPrimitivePlancyclenumberValue:(int16_t)value_ {
	[self setPrimitivePlancyclenumber:[NSNumber numberWithShort:value_]];
}

@dynamic planflag;

@dynamic planid;

@dynamic planimported;

@dynamic planlevel;

@dynamic plannumber;

- (int16_t)plannumberValue {
	NSNumber *result = [self plannumber];
	return [result shortValue];
}

- (void)setPlannumberValue:(int16_t)value_ {
	[self setPlannumber:[NSNumber numberWithShort:value_]];
}

- (int16_t)primitivePlannumberValue {
	NSNumber *result = [self primitivePlannumber];
	return [result shortValue];
}

- (void)setPrimitivePlannumberValue:(int16_t)value_ {
	[self setPrimitivePlannumber:[NSNumber numberWithShort:value_]];
}

@dynamic planpublic;

@dynamic planstate;

@dynamic plantitle;

@dynamic plantype;

@dynamic finishedplanuser;

@dynamic friend;

@dynamic friendfinishplan;

@dynamic friendstartplan;

@dynamic smallhealthplan;

- (NSMutableSet*)smallhealthplanSet {
	[self willAccessValueForKey:@"smallhealthplan"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"smallhealthplan"];

	[self didAccessValueForKey:@"smallhealthplan"];
	return result;
}

@dynamic user;

@dynamic usertoimportplanrenqi;

@dynamic usertoimportplantime;

@dynamic usertootherplan;

@dynamic usertosystemplan;

@end

