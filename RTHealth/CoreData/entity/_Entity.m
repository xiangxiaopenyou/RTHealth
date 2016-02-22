// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Entity.m instead.

#import "_Entity.h"

const struct EntityAttributes EntityAttributes = {
	.attribute = @"attribute",
};

const struct EntityRelationships EntityRelationships = {
	.relationship = @"relationship",
};

@implementation EntityID
@end

@implementation _Entity

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Entity" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Entity";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Entity" inManagedObjectContext:moc_];
}

- (EntityID*)objectID {
	return (EntityID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic attribute;

@dynamic relationship;

- (NSMutableSet*)relationshipSet {
	[self willAccessValueForKey:@"relationship"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"relationship"];

	[self didAccessValueForKey:@"relationship"];
	return result;
}

@end

