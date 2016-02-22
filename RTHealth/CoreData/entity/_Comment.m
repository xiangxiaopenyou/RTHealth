// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Comment.m instead.

#import "_Comment.h"

const struct CommentAttributes CommentAttributes = {
	.commentcontent = @"commentcontent",
	.commentid = @"commentid",
	.commenttime = @"commenttime",
	.commenttouserid = @"commenttouserid",
	.commenttousername = @"commenttousername",
	.commentuserid = @"commentuserid",
	.commentusername = @"commentusername",
	.commentuserphoto = @"commentuserphoto",
};

const struct CommentRelationships CommentRelationships = {
	.trend = @"trend",
};

@implementation CommentID
@end

@implementation _Comment

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Comment" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Comment";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Comment" inManagedObjectContext:moc_];
}

- (CommentID*)objectID {
	return (CommentID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic commentcontent;

@dynamic commentid;

@dynamic commenttime;

@dynamic commenttouserid;

@dynamic commenttousername;

@dynamic commentuserid;

@dynamic commentusername;

@dynamic commentuserphoto;

@dynamic trend;

@end

