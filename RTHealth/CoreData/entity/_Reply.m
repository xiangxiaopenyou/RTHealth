// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Reply.m instead.

#import "_Reply.h"

const struct ReplyAttributes ReplyAttributes = {
	.replycontent = @"replycontent",
	.replyforusercontent = @"replyforusercontent",
	.replyforuserid = @"replyforuserid",
	.replyforusernickname = @"replyforusernickname",
	.replyfriendid = @"replyfriendid",
	.replyfriendnickname = @"replyfriendnickname",
	.replyfriendtpye = @"replyfriendtpye",
	.replyid = @"replyid",
	.replyisread = @"replyisread",
	.replytime = @"replytime",
	.replytype = @"replytype",
	.replyuserid = @"replyuserid",
	.replyusernickname = @"replyusernickname",
	.replyuserphoto = @"replyuserphoto",
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
};

const struct ReplyRelationships ReplyRelationships = {
	.user = @"user",
};

@implementation ReplyID
@end

@implementation _Reply

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Reply" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Reply";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Reply" inManagedObjectContext:moc_];
}

- (ReplyID*)objectID {
	return (ReplyID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic replycontent;

@dynamic replyforusercontent;

@dynamic replyforuserid;

@dynamic replyforusernickname;

@dynamic replyfriendid;

@dynamic replyfriendnickname;

@dynamic replyfriendtpye;

@dynamic replyid;

@dynamic replyisread;

@dynamic replytime;

@dynamic replytype;

@dynamic replyuserid;

@dynamic replyusernickname;

@dynamic replyuserphoto;

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

@dynamic user;

@end

