// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to UserInfo.m instead.

#import "_UserInfo.h"

const struct UserInfoAttributes UserInfoAttributes = {
	.isnewuser = @"isnewuser",
	.useractivitynumber = @"useractivitynumber",
	.userattentionnumber = @"userattentionnumber",
	.userbirthday = @"userbirthday",
	.userfansnumber = @"userfansnumber",
	.userfavoritesports = @"userfavoritesports",
	.usergeopoint = @"usergeopoint",
	.userheight = @"userheight",
	.userheightpublic = @"userheightpublic",
	.userid = @"userid",
	.userintroduce = @"userintroduce",
	.username = @"username",
	.usernickname = @"usernickname",
	.userphoto = @"userphoto",
	.userpoint = @"userpoint",
	.usersex = @"usersex",
	.usertoken = @"usertoken",
	.userweight = @"userweight",
	.userweightpublic = @"userweightpublic",
};

const struct UserInfoRelationships UserInfoRelationships = {
	.activity = @"activity",
	.activitydetail = @"activitydetail",
	.activityrecommend = @"activityrecommend",
	.addactivitydistance = @"addactivitydistance",
	.addactivitytime = @"addactivitytime",
	.alltrends = @"alltrends",
	.attentionuser = @"attentionuser",
	.canstartplan = @"canstartplan",
	.chat = @"chat",
	.fansofmy = @"fansofmy",
	.finishedactivity = @"finishedactivity",
	.finishedplan = @"finishedplan",
	.friendfinishedactivity = @"friendfinishedactivity",
	.friendtrends = @"friendtrends",
	.friendunderwayactivity = @"friendunderwayactivity",
	.healthplan = @"healthplan",
	.importplanrenqi = @"importplanrenqi",
	.importplantime = @"importplantime",
	.liketrends = @"liketrends",
	.nearbyuser = @"nearbyuser",
	.popularityuser = @"popularityuser",
	.praise = @"praise",
	.remind = @"remind",
	.reply = @"reply",
	.sportstrends = @"sportstrends",
	.systemmessage = @"systemmessage",
	.systemplan = @"systemplan",
	.teacheruser = @"teacheruser",
	.underwayactivity = @"underwayactivity",
	.usertopic = @"usertopic",
	.usertrends = @"usertrends",
};

@implementation UserInfoID
@end

@implementation _UserInfo

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"UserInfo" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"UserInfo";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"UserInfo" inManagedObjectContext:moc_];
}

- (UserInfoID*)objectID {
	return (UserInfoID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"userheightpublicValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"userheightpublic"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"userweightpublicValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"userweightpublic"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}

@dynamic isnewuser;

@dynamic useractivitynumber;

@dynamic userattentionnumber;

@dynamic userbirthday;

@dynamic userfansnumber;

@dynamic userfavoritesports;

@dynamic usergeopoint;

@dynamic userheight;

@dynamic userheightpublic;

- (BOOL)userheightpublicValue {
	NSNumber *result = [self userheightpublic];
	return [result boolValue];
}

- (void)setUserheightpublicValue:(BOOL)value_ {
	[self setUserheightpublic:[NSNumber numberWithBool:value_]];
}

- (BOOL)primitiveUserheightpublicValue {
	NSNumber *result = [self primitiveUserheightpublic];
	return [result boolValue];
}

- (void)setPrimitiveUserheightpublicValue:(BOOL)value_ {
	[self setPrimitiveUserheightpublic:[NSNumber numberWithBool:value_]];
}

@dynamic userid;

@dynamic userintroduce;

@dynamic username;

@dynamic usernickname;

@dynamic userphoto;

@dynamic userpoint;

@dynamic usersex;

@dynamic usertoken;

@dynamic userweight;

@dynamic userweightpublic;

- (BOOL)userweightpublicValue {
	NSNumber *result = [self userweightpublic];
	return [result boolValue];
}

- (void)setUserweightpublicValue:(BOOL)value_ {
	[self setUserweightpublic:[NSNumber numberWithBool:value_]];
}

- (BOOL)primitiveUserweightpublicValue {
	NSNumber *result = [self primitiveUserweightpublic];
	return [result boolValue];
}

- (void)setPrimitiveUserweightpublicValue:(BOOL)value_ {
	[self setPrimitiveUserweightpublic:[NSNumber numberWithBool:value_]];
}

@dynamic activity;

- (NSMutableSet*)activitySet {
	[self willAccessValueForKey:@"activity"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"activity"];

	[self didAccessValueForKey:@"activity"];
	return result;
}

@dynamic activitydetail;

@dynamic activityrecommend;

- (NSMutableSet*)activityrecommendSet {
	[self willAccessValueForKey:@"activityrecommend"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"activityrecommend"];

	[self didAccessValueForKey:@"activityrecommend"];
	return result;
}

@dynamic addactivitydistance;

- (NSMutableSet*)addactivitydistanceSet {
	[self willAccessValueForKey:@"addactivitydistance"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"addactivitydistance"];

	[self didAccessValueForKey:@"addactivitydistance"];
	return result;
}

@dynamic addactivitytime;

- (NSMutableSet*)addactivitytimeSet {
	[self willAccessValueForKey:@"addactivitytime"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"addactivitytime"];

	[self didAccessValueForKey:@"addactivitytime"];
	return result;
}

@dynamic alltrends;

- (NSMutableSet*)alltrendsSet {
	[self willAccessValueForKey:@"alltrends"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"alltrends"];

	[self didAccessValueForKey:@"alltrends"];
	return result;
}

@dynamic attentionuser;

- (NSMutableSet*)attentionuserSet {
	[self willAccessValueForKey:@"attentionuser"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"attentionuser"];

	[self didAccessValueForKey:@"attentionuser"];
	return result;
}

@dynamic canstartplan;

- (NSMutableSet*)canstartplanSet {
	[self willAccessValueForKey:@"canstartplan"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"canstartplan"];

	[self didAccessValueForKey:@"canstartplan"];
	return result;
}

@dynamic chat;

- (NSMutableSet*)chatSet {
	[self willAccessValueForKey:@"chat"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"chat"];

	[self didAccessValueForKey:@"chat"];
	return result;
}

@dynamic fansofmy;

- (NSMutableSet*)fansofmySet {
	[self willAccessValueForKey:@"fansofmy"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"fansofmy"];

	[self didAccessValueForKey:@"fansofmy"];
	return result;
}

@dynamic finishedactivity;

- (NSMutableSet*)finishedactivitySet {
	[self willAccessValueForKey:@"finishedactivity"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"finishedactivity"];

	[self didAccessValueForKey:@"finishedactivity"];
	return result;
}

@dynamic finishedplan;

- (NSMutableSet*)finishedplanSet {
	[self willAccessValueForKey:@"finishedplan"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"finishedplan"];

	[self didAccessValueForKey:@"finishedplan"];
	return result;
}

@dynamic friendfinishedactivity;

- (NSMutableSet*)friendfinishedactivitySet {
	[self willAccessValueForKey:@"friendfinishedactivity"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"friendfinishedactivity"];

	[self didAccessValueForKey:@"friendfinishedactivity"];
	return result;
}

@dynamic friendtrends;

- (NSMutableSet*)friendtrendsSet {
	[self willAccessValueForKey:@"friendtrends"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"friendtrends"];

	[self didAccessValueForKey:@"friendtrends"];
	return result;
}

@dynamic friendunderwayactivity;

- (NSMutableSet*)friendunderwayactivitySet {
	[self willAccessValueForKey:@"friendunderwayactivity"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"friendunderwayactivity"];

	[self didAccessValueForKey:@"friendunderwayactivity"];
	return result;
}

@dynamic healthplan;

@dynamic importplanrenqi;

- (NSMutableSet*)importplanrenqiSet {
	[self willAccessValueForKey:@"importplanrenqi"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"importplanrenqi"];

	[self didAccessValueForKey:@"importplanrenqi"];
	return result;
}

@dynamic importplantime;

- (NSMutableSet*)importplantimeSet {
	[self willAccessValueForKey:@"importplantime"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"importplantime"];

	[self didAccessValueForKey:@"importplantime"];
	return result;
}

@dynamic liketrends;

- (NSMutableSet*)liketrendsSet {
	[self willAccessValueForKey:@"liketrends"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"liketrends"];

	[self didAccessValueForKey:@"liketrends"];
	return result;
}

@dynamic nearbyuser;

- (NSMutableSet*)nearbyuserSet {
	[self willAccessValueForKey:@"nearbyuser"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"nearbyuser"];

	[self didAccessValueForKey:@"nearbyuser"];
	return result;
}

@dynamic popularityuser;

- (NSMutableSet*)popularityuserSet {
	[self willAccessValueForKey:@"popularityuser"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"popularityuser"];

	[self didAccessValueForKey:@"popularityuser"];
	return result;
}

@dynamic praise;

- (NSMutableSet*)praiseSet {
	[self willAccessValueForKey:@"praise"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"praise"];

	[self didAccessValueForKey:@"praise"];
	return result;
}

@dynamic remind;

- (NSMutableSet*)remindSet {
	[self willAccessValueForKey:@"remind"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"remind"];

	[self didAccessValueForKey:@"remind"];
	return result;
}

@dynamic reply;

- (NSMutableSet*)replySet {
	[self willAccessValueForKey:@"reply"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"reply"];

	[self didAccessValueForKey:@"reply"];
	return result;
}

@dynamic sportstrends;

- (NSMutableSet*)sportstrendsSet {
	[self willAccessValueForKey:@"sportstrends"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"sportstrends"];

	[self didAccessValueForKey:@"sportstrends"];
	return result;
}

@dynamic systemmessage;

- (NSMutableSet*)systemmessageSet {
	[self willAccessValueForKey:@"systemmessage"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"systemmessage"];

	[self didAccessValueForKey:@"systemmessage"];
	return result;
}

@dynamic systemplan;

- (NSMutableSet*)systemplanSet {
	[self willAccessValueForKey:@"systemplan"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"systemplan"];

	[self didAccessValueForKey:@"systemplan"];
	return result;
}

@dynamic teacheruser;

- (NSMutableSet*)teacheruserSet {
	[self willAccessValueForKey:@"teacheruser"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"teacheruser"];

	[self didAccessValueForKey:@"teacheruser"];
	return result;
}

@dynamic underwayactivity;

- (NSMutableSet*)underwayactivitySet {
	[self willAccessValueForKey:@"underwayactivity"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"underwayactivity"];

	[self didAccessValueForKey:@"underwayactivity"];
	return result;
}

@dynamic usertopic;

- (NSMutableSet*)usertopicSet {
	[self willAccessValueForKey:@"usertopic"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"usertopic"];

	[self didAccessValueForKey:@"usertopic"];
	return result;
}

@dynamic usertrends;

- (NSMutableSet*)usertrendsSet {
	[self willAccessValueForKey:@"usertrends"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"usertrends"];

	[self didAccessValueForKey:@"usertrends"];
	return result;
}

@end

