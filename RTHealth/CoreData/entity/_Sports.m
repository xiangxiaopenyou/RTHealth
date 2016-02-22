// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Sports.m instead.

#import "_Sports.h"

const struct SportsAttributes SportsAttributes = {
	.sportid = @"sportid",
	.sportname = @"sportname",
	.sportphoto = @"sportphoto",
};

const struct SportsRelationships SportsRelationships = {
	.favouritesport = @"favouritesport",
	.friendfavourite = @"friendfavourite",
};

@implementation SportsID
@end

@implementation _Sports

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Sports" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Sports";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Sports" inManagedObjectContext:moc_];
}

- (SportsID*)objectID {
	return (SportsID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic sportid;

@dynamic sportname;

@dynamic sportphoto;

@dynamic favouritesport;

@dynamic friendfavourite;

@end

