// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Chat.m instead.

#import "_Chat.h"

const struct ChatAttributes ChatAttributes = {
	.chatlastcontent = @"chatlastcontent",
	.chatlasttime = @"chatlasttime",
	.chatuserid = @"chatuserid",
	.chatusernickname = @"chatusernickname",
	.chatuserphoto = @"chatuserphoto",
};

const struct ChatRelationships ChatRelationships = {
	.chatlist = @"chatlist",
	.user = @"user",
};

@implementation ChatID
@end

@implementation _Chat

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Chat" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Chat";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Chat" inManagedObjectContext:moc_];
}

- (ChatID*)objectID {
	return (ChatID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic chatlastcontent;

@dynamic chatlasttime;

@dynamic chatuserid;

@dynamic chatusernickname;

@dynamic chatuserphoto;

@dynamic chatlist;

- (NSMutableSet*)chatlistSet {
	[self willAccessValueForKey:@"chatlist"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"chatlist"];

	[self didAccessValueForKey:@"chatlist"];
	return result;
}

@dynamic user;

@end

