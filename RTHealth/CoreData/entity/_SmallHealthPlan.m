// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SmallHealthPlan.m instead.

#import "_SmallHealthPlan.h"

const struct SmallHealthPlanAttributes SmallHealthPlanAttributes = {
	.smallplanbegintime = @"smallplanbegintime",
	.smallplancontent = @"smallplancontent",
	.smallplancost = @"smallplancost",
	.smallplancycle = @"smallplancycle",
	.smallplanendtime = @"smallplanendtime",
	.smallplanid = @"smallplanid",
	.smallplanmark = @"smallplanmark",
	.smallplansequence = @"smallplansequence",
	.smallplanstateflag = @"smallplanstateflag",
	.smallplantype = @"smallplantype",
};

const struct SmallHealthPlanRelationships SmallHealthPlanRelationships = {
	.healthplan = @"healthplan",
};

@implementation SmallHealthPlanID
@end

@implementation _SmallHealthPlan

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"SmallHealthPlan" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"SmallHealthPlan";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"SmallHealthPlan" inManagedObjectContext:moc_];
}

- (SmallHealthPlanID*)objectID {
	return (SmallHealthPlanID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic smallplanbegintime;

@dynamic smallplancontent;

@dynamic smallplancost;

@dynamic smallplancycle;

@dynamic smallplanendtime;

@dynamic smallplanid;

@dynamic smallplanmark;

@dynamic smallplansequence;

@dynamic smallplanstateflag;

@dynamic smallplantype;

@dynamic healthplan;

@end

