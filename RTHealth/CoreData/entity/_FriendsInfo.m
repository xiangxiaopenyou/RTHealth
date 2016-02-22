// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to FriendsInfo.m instead.

#import "_FriendsInfo.h"

const struct FriendsInfoAttributes FriendsInfoAttributes = {
	.firendage = @"firendage",
	.friendactivitynumber = @"friendactivitynumber",
	.friendattentionnumber = @"friendattentionnumber",
	.friendbirthday = @"friendbirthday",
	.friendcreatetime = @"friendcreatetime",
	.frienddistance = @"frienddistance",
	.friendfansnumber = @"friendfansnumber",
	.friendfavoritesports = @"friendfavoritesports",
	.friendflag = @"friendflag",
	.friendheight = @"friendheight",
	.friendid = @"friendid",
	.friendintroduce = @"friendintroduce",
	.friendisattention = @"friendisattention",
	.friendname = @"friendname",
	.friendnickname = @"friendnickname",
	.friendphoto = @"friendphoto",
	.friendpoint = @"friendpoint",
	.friendpopularity = @"friendpopularity",
	.friendsex = @"friendsex",
	.friendstate = @"friendstate",
	.friendtype = @"friendtype",
	.friendweight = @"friendweight",
};

const struct FriendsInfoRelationships FriendsInfoRelationships = {
	.activitytakein = @"activitytakein",
	.canstartplan = @"canstartplan",
	.finishplan = @"finishplan",
	.friendattention = @"friendattention",
	.friendfans = @"friendfans",
	.healthplan = @"healthplan",
	.popularityofuser = @"popularityofuser",
	.teachofuser = @"teachofuser",
	.trendfavorite = @"trendfavorite",
	.trendshared = @"trendshared",
	.user = @"user",
	.useroffans = @"useroffans",
	.userofnear = @"userofnear",
};

@implementation FriendsInfoID
@end

@implementation _FriendsInfo

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"FriendsInfo" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"FriendsInfo";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"FriendsInfo" inManagedObjectContext:moc_];
}

- (FriendsInfoID*)objectID {
	return (FriendsInfoID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"firendageValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"firendage"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"frienddistanceValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"frienddistance"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"friendfansnumberValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"friendfansnumber"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}

@dynamic firendage;

- (int16_t)firendageValue {
	NSNumber *result = [self firendage];
	return [result shortValue];
}

- (void)setFirendageValue:(int16_t)value_ {
	[self setFirendage:[NSNumber numberWithShort:value_]];
}

- (int16_t)primitiveFirendageValue {
	NSNumber *result = [self primitiveFirendage];
	return [result shortValue];
}

- (void)setPrimitiveFirendageValue:(int16_t)value_ {
	[self setPrimitiveFirendage:[NSNumber numberWithShort:value_]];
}

@dynamic friendactivitynumber;

@dynamic friendattentionnumber;

@dynamic friendbirthday;

@dynamic friendcreatetime;

@dynamic frienddistance;

- (float)frienddistanceValue {
	NSNumber *result = [self frienddistance];
	return [result floatValue];
}

- (void)setFrienddistanceValue:(float)value_ {
	[self setFrienddistance:[NSNumber numberWithFloat:value_]];
}

- (float)primitiveFrienddistanceValue {
	NSNumber *result = [self primitiveFrienddistance];
	return [result floatValue];
}

- (void)setPrimitiveFrienddistanceValue:(float)value_ {
	[self setPrimitiveFrienddistance:[NSNumber numberWithFloat:value_]];
}

@dynamic friendfansnumber;

- (int16_t)friendfansnumberValue {
	NSNumber *result = [self friendfansnumber];
	return [result shortValue];
}

- (void)setFriendfansnumberValue:(int16_t)value_ {
	[self setFriendfansnumber:[NSNumber numberWithShort:value_]];
}

- (int16_t)primitiveFriendfansnumberValue {
	NSNumber *result = [self primitiveFriendfansnumber];
	return [result shortValue];
}

- (void)setPrimitiveFriendfansnumberValue:(int16_t)value_ {
	[self setPrimitiveFriendfansnumber:[NSNumber numberWithShort:value_]];
}

@dynamic friendfavoritesports;

@dynamic friendflag;

@dynamic friendheight;

@dynamic friendid;

@dynamic friendintroduce;

@dynamic friendisattention;

@dynamic friendname;

@dynamic friendnickname;

@dynamic friendphoto;

@dynamic friendpoint;

@dynamic friendpopularity;

@dynamic friendsex;

@dynamic friendstate;

@dynamic friendtype;

@dynamic friendweight;

@dynamic activitytakein;

@dynamic canstartplan;

- (NSMutableSet*)canstartplanSet {
	[self willAccessValueForKey:@"canstartplan"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"canstartplan"];

	[self didAccessValueForKey:@"canstartplan"];
	return result;
}

@dynamic finishplan;

- (NSMutableSet*)finishplanSet {
	[self willAccessValueForKey:@"finishplan"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"finishplan"];

	[self didAccessValueForKey:@"finishplan"];
	return result;
}

@dynamic friendattention;

- (NSMutableSet*)friendattentionSet {
	[self willAccessValueForKey:@"friendattention"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"friendattention"];

	[self didAccessValueForKey:@"friendattention"];
	return result;
}

@dynamic friendfans;

- (NSMutableSet*)friendfansSet {
	[self willAccessValueForKey:@"friendfans"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"friendfans"];

	[self didAccessValueForKey:@"friendfans"];
	return result;
}

@dynamic healthplan;

@dynamic popularityofuser;

@dynamic teachofuser;

@dynamic trendfavorite;

@dynamic trendshared;

@dynamic user;

@dynamic useroffans;

@dynamic userofnear;

@end

