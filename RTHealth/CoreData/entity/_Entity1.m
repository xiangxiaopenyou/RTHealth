// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Entity1.m instead.

#import "_Entity1.h"

const struct Entity1Attributes Entity1Attributes = {
	.attribute = @"attribute",
};

const struct Entity1Relationships Entity1Relationships = {
	.relationship = @"relationship",
};

@implementation Entity1ID
@end

@implementation _Entity1

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Entity1" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Entity1";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Entity1" inManagedObjectContext:moc_];
}

- (Entity1ID*)objectID {
	return (Entity1ID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic attribute;

@dynamic relationship;

@end

