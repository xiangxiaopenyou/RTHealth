// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SystemMessage.m instead.

#import "_SystemMessage.h"

const struct SystemMessageAttributes SystemMessageAttributes = {
	.systemmessagecontent = @"systemmessagecontent",
	.systemmessageid = @"systemmessageid",
	.systemmessageisread = @"systemmessageisread",
	.systemmessagelink = @"systemmessagelink",
	.systemmessagephoto = @"systemmessagephoto",
	.systemmessagetime = @"systemmessagetime",
	.systemmessagetopic = @"systemmessagetopic",
	.systemmessagetype = @"systemmessagetype",
	.systemphoto = @"systemphoto",
};

const struct SystemMessageRelationships SystemMessageRelationships = {
	.user = @"user",
};

@implementation SystemMessageID
@end

@implementation _SystemMessage

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"SystemMessage" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"SystemMessage";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"SystemMessage" inManagedObjectContext:moc_];
}

- (SystemMessageID*)objectID {
	return (SystemMessageID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic systemmessagecontent;

@dynamic systemmessageid;

@dynamic systemmessageisread;

@dynamic systemmessagelink;

@dynamic systemmessagephoto;

@dynamic systemmessagetime;

@dynamic systemmessagetopic;

@dynamic systemmessagetype;

@dynamic systemphoto;

@dynamic user;

@end

