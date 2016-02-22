// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ChatList.m instead.

#import "_ChatList.h"

const struct ChatListAttributes ChatListAttributes = {
	.chatcontent = @"chatcontent",
	.chatid = @"chatid",
	.chatisread = @"chatisread",
	.chattime = @"chattime",
	.chattype = @"chattype",
};

const struct ChatListRelationships ChatListRelationships = {
	.chat = @"chat",
};

@implementation ChatListID
@end

@implementation _ChatList

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"ChatList" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"ChatList";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"ChatList" inManagedObjectContext:moc_];
}

- (ChatListID*)objectID {
	return (ChatListID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic chatcontent;

@dynamic chatid;

@dynamic chatisread;

@dynamic chattime;

@dynamic chattype;

@dynamic chat;

@end

