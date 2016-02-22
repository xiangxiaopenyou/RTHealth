// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Remind.m instead.

#import "_Remind.h"

const struct RemindAttributes RemindAttributes = {
	.remindcontent = @"remindcontent",
	.remindid = @"remindid",
	.remindisread = @"remindisread",
	.remindsomeid = @"remindsomeid",
	.remindsometitle = @"remindsometitle",
	.remindtime = @"remindtime",
	.remindtype = @"remindtype",
	.reminduserid = @"reminduserid",
	.remindusernickname = @"remindusernickname",
};

const struct RemindRelationships RemindRelationships = {
	.user = @"user",
};

@implementation RemindID
@end

@implementation _Remind

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Remind" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Remind";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Remind" inManagedObjectContext:moc_];
}

- (RemindID*)objectID {
	return (RemindID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic remindcontent;

@dynamic remindid;

@dynamic remindisread;

@dynamic remindsomeid;

@dynamic remindsometitle;

@dynamic remindtime;

@dynamic remindtype;

@dynamic reminduserid;

@dynamic remindusernickname;

@dynamic user;

@end

