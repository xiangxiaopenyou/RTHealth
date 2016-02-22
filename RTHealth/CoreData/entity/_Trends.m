// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Trends.m instead.

#import "_Trends.h"

const struct TrendsAttributes TrendsAttributes = {
	.isfavorite = @"isfavorite",
	.ispublic = @"ispublic",
	.trendclassify = @"trendclassify",
	.trendcommentnumber = @"trendcommentnumber",
	.trendcontent = @"trendcontent",
	.trendfavoritenumber = @"trendfavoritenumber",
	.trendid = @"trendid",
	.trendphoto = @"trendphoto",
	.trendsharednumber = @"trendsharednumber",
	.trendtime = @"trendtime",
	.trendtype = @"trendtype",
	.useraddress = @"useraddress",
	.userid = @"userid",
	.usernickname = @"usernickname",
	.userphoto = @"userphoto",
	.usersex = @"usersex",
	.usertype = @"usertype",
};

const struct TrendsRelationships TrendsRelationships = {
	.comments = @"comments",
	.favorite = @"favorite",
	.shared = @"shared",
	.trendsofall = @"trendsofall",
	.trendsoffriend = @"trendsoffriend",
	.trendsoflike = @"trendsoflike",
	.trendsofsports = @"trendsofsports",
	.trendsofuser = @"trendsofuser",
};

@implementation TrendsID
@end

@implementation _Trends

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Trends" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Trends";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Trends" inManagedObjectContext:moc_];
}

- (TrendsID*)objectID {
	return (TrendsID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic isfavorite;

@dynamic ispublic;

@dynamic trendclassify;

@dynamic trendcommentnumber;

@dynamic trendcontent;

@dynamic trendfavoritenumber;

@dynamic trendid;

@dynamic trendphoto;

@dynamic trendsharednumber;

@dynamic trendtime;

@dynamic trendtype;

@dynamic useraddress;

@dynamic userid;

@dynamic usernickname;

@dynamic userphoto;

@dynamic usersex;

@dynamic usertype;

@dynamic comments;

- (NSMutableSet*)commentsSet {
	[self willAccessValueForKey:@"comments"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"comments"];

	[self didAccessValueForKey:@"comments"];
	return result;
}

@dynamic favorite;

- (NSMutableSet*)favoriteSet {
	[self willAccessValueForKey:@"favorite"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"favorite"];

	[self didAccessValueForKey:@"favorite"];
	return result;
}

@dynamic shared;

- (NSMutableSet*)sharedSet {
	[self willAccessValueForKey:@"shared"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"shared"];

	[self didAccessValueForKey:@"shared"];
	return result;
}

@dynamic trendsofall;

@dynamic trendsoffriend;

@dynamic trendsoflike;

@dynamic trendsofsports;

@dynamic trendsofuser;

@end

