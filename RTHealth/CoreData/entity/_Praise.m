// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Praise.m instead.

#import "_Praise.h"

const struct PraiseAttributes PraiseAttributes = {
	.praiseisread = @"praiseisread",
	.praisetime = @"praisetime",
	.praiseuserid = @"praiseuserid",
	.praiseusernickname = @"praiseusernickname",
	.praiseuserphoto = @"praiseuserphoto",
	.trendaddress = @"trendaddress",
	.trendcommentnumber = @"trendcommentnumber",
	.trendcontent = @"trendcontent",
	.trendcreatetime = @"trendcreatetime",
	.trendid = @"trendid",
	.trendlabel = @"trendlabel",
	.trendlike = @"trendlike",
	.trendlocat = @"trendlocat",
	.trendphoto = @"trendphoto",
	.trendsex = @"trendsex",
	.trendtitle = @"trendtitle",
	.trenduserhead = @"trenduserhead",
	.trenduserid = @"trenduserid",
	.trendusertype = @"trendusertype",
	.username = @"username",
	.userphoto = @"userphoto",
};

const struct PraiseRelationships PraiseRelationships = {
	.user = @"user",
};

@implementation PraiseID
@end

@implementation _Praise

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Praise" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Praise";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Praise" inManagedObjectContext:moc_];
}

- (PraiseID*)objectID {
	return (PraiseID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic praiseisread;

@dynamic praisetime;

@dynamic praiseuserid;

@dynamic praiseusernickname;

@dynamic praiseuserphoto;

@dynamic trendaddress;

@dynamic trendcommentnumber;

@dynamic trendcontent;

@dynamic trendcreatetime;

@dynamic trendid;

@dynamic trendlabel;

@dynamic trendlike;

@dynamic trendlocat;

@dynamic trendphoto;

@dynamic trendsex;

@dynamic trendtitle;

@dynamic trenduserhead;

@dynamic trenduserid;

@dynamic trendusertype;

@dynamic username;

@dynamic userphoto;

@dynamic user;

@end

