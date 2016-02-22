// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Activity.m instead.

#import "_Activity.h"

const struct ActivityAttributes ActivityAttributes = {
	.activitybegintime = @"activitybegintime",
	.activitycontent = @"activitycontent",
	.activitycreatedtime = @"activitycreatedtime",
	.activitydistance = @"activitydistance",
	.activityendtime = @"activityendtime",
	.activityid = @"activityid",
	.activitylimitnumber = @"activitylimitnumber",
	.activitylimittime = @"activitylimittime",
	.activitynumber = @"activitynumber",
	.activityownerid = @"activityownerid",
	.activityownernickname = @"activityownernickname",
	.activityplace = @"activityplace",
	.activityposition = @"activityposition",
	.activitytelephone = @"activitytelephone",
	.activitytitle = @"activitytitle",
	.positionlatitude = @"positionlatitude",
	.positionlongitude = @"positionlongitude",
};

const struct ActivityRelationships ActivityRelationships = {
	.detailofactivity = @"detailofactivity",
	.finishedfriend = @"finishedfriend",
	.finisheduser = @"finisheduser",
	.underwayfriend = @"underwayfriend",
	.underwayuser = @"underwayuser",
	.useractivity = @"useractivity",
	.useroftopic = @"useroftopic",
	.userrecommend = @"userrecommend",
	.usertakein = @"usertakein",
	.usertoaddactivitydistance = @"usertoaddactivitydistance",
	.usertoaddactivitytime = @"usertoaddactivitytime",
};

@implementation ActivityID
@end

@implementation _Activity

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Activity" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Activity";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Activity" inManagedObjectContext:moc_];
}

- (ActivityID*)objectID {
	return (ActivityID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic activitybegintime;

@dynamic activitycontent;

@dynamic activitycreatedtime;

@dynamic activitydistance;

@dynamic activityendtime;

@dynamic activityid;

@dynamic activitylimitnumber;

@dynamic activitylimittime;

@dynamic activitynumber;

@dynamic activityownerid;

@dynamic activityownernickname;

@dynamic activityplace;

@dynamic activityposition;

@dynamic activitytelephone;

@dynamic activitytitle;

@dynamic positionlatitude;

@dynamic positionlongitude;

@dynamic detailofactivity;

@dynamic finishedfriend;

@dynamic finisheduser;

@dynamic underwayfriend;

@dynamic underwayuser;

@dynamic useractivity;

@dynamic useroftopic;

@dynamic userrecommend;

@dynamic usertakein;

- (NSMutableSet*)usertakeinSet {
	[self willAccessValueForKey:@"usertakein"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"usertakein"];

	[self didAccessValueForKey:@"usertakein"];
	return result;
}

@dynamic usertoaddactivitydistance;

@dynamic usertoaddactivitytime;

@end

