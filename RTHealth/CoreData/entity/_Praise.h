// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Praise.h instead.

#import <CoreData/CoreData.h>

extern const struct PraiseAttributes {
	__unsafe_unretained NSString *praiseisread;
	__unsafe_unretained NSString *praisetime;
	__unsafe_unretained NSString *praiseuserid;
	__unsafe_unretained NSString *praiseusernickname;
	__unsafe_unretained NSString *praiseuserphoto;
	__unsafe_unretained NSString *trendaddress;
	__unsafe_unretained NSString *trendcommentnumber;
	__unsafe_unretained NSString *trendcontent;
	__unsafe_unretained NSString *trendcreatetime;
	__unsafe_unretained NSString *trendid;
	__unsafe_unretained NSString *trendlabel;
	__unsafe_unretained NSString *trendlike;
	__unsafe_unretained NSString *trendlocat;
	__unsafe_unretained NSString *trendphoto;
	__unsafe_unretained NSString *trendsex;
	__unsafe_unretained NSString *trendtitle;
	__unsafe_unretained NSString *trenduserhead;
	__unsafe_unretained NSString *trenduserid;
	__unsafe_unretained NSString *trendusertype;
	__unsafe_unretained NSString *username;
	__unsafe_unretained NSString *userphoto;
} PraiseAttributes;

extern const struct PraiseRelationships {
	__unsafe_unretained NSString *user;
} PraiseRelationships;

@class UserInfo;

@interface PraiseID : NSManagedObjectID {}
@end

@interface _Praise : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) PraiseID* objectID;

@property (nonatomic, strong) NSString* praiseisread;

//- (BOOL)validatePraiseisread:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* praisetime;

//- (BOOL)validatePraisetime:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* praiseuserid;

//- (BOOL)validatePraiseuserid:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* praiseusernickname;

//- (BOOL)validatePraiseusernickname:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* praiseuserphoto;

//- (BOOL)validatePraiseuserphoto:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* trendaddress;

//- (BOOL)validateTrendaddress:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* trendcommentnumber;

//- (BOOL)validateTrendcommentnumber:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* trendcontent;

//- (BOOL)validateTrendcontent:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* trendcreatetime;

//- (BOOL)validateTrendcreatetime:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* trendid;

//- (BOOL)validateTrendid:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* trendlabel;

//- (BOOL)validateTrendlabel:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* trendlike;

//- (BOOL)validateTrendlike:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* trendlocat;

//- (BOOL)validateTrendlocat:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* trendphoto;

//- (BOOL)validateTrendphoto:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* trendsex;

//- (BOOL)validateTrendsex:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* trendtitle;

//- (BOOL)validateTrendtitle:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* trenduserhead;

//- (BOOL)validateTrenduserhead:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* trenduserid;

//- (BOOL)validateTrenduserid:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* trendusertype;

//- (BOOL)validateTrendusertype:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* username;

//- (BOOL)validateUsername:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* userphoto;

//- (BOOL)validateUserphoto:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) UserInfo *user;

//- (BOOL)validateUser:(id*)value_ error:(NSError**)error_;

@end

@interface _Praise (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitivePraiseisread;
- (void)setPrimitivePraiseisread:(NSString*)value;

- (NSString*)primitivePraisetime;
- (void)setPrimitivePraisetime:(NSString*)value;

- (NSString*)primitivePraiseuserid;
- (void)setPrimitivePraiseuserid:(NSString*)value;

- (NSString*)primitivePraiseusernickname;
- (void)setPrimitivePraiseusernickname:(NSString*)value;

- (NSString*)primitivePraiseuserphoto;
- (void)setPrimitivePraiseuserphoto:(NSString*)value;

- (NSString*)primitiveTrendaddress;
- (void)setPrimitiveTrendaddress:(NSString*)value;

- (NSString*)primitiveTrendcommentnumber;
- (void)setPrimitiveTrendcommentnumber:(NSString*)value;

- (NSString*)primitiveTrendcontent;
- (void)setPrimitiveTrendcontent:(NSString*)value;

- (NSString*)primitiveTrendcreatetime;
- (void)setPrimitiveTrendcreatetime:(NSString*)value;

- (NSString*)primitiveTrendid;
- (void)setPrimitiveTrendid:(NSString*)value;

- (NSString*)primitiveTrendlabel;
- (void)setPrimitiveTrendlabel:(NSString*)value;

- (NSString*)primitiveTrendlike;
- (void)setPrimitiveTrendlike:(NSString*)value;

- (NSString*)primitiveTrendlocat;
- (void)setPrimitiveTrendlocat:(NSString*)value;

- (NSString*)primitiveTrendphoto;
- (void)setPrimitiveTrendphoto:(NSString*)value;

- (NSString*)primitiveTrendsex;
- (void)setPrimitiveTrendsex:(NSString*)value;

- (NSString*)primitiveTrendtitle;
- (void)setPrimitiveTrendtitle:(NSString*)value;

- (NSString*)primitiveTrenduserhead;
- (void)setPrimitiveTrenduserhead:(NSString*)value;

- (NSString*)primitiveTrenduserid;
- (void)setPrimitiveTrenduserid:(NSString*)value;

- (NSString*)primitiveTrendusertype;
- (void)setPrimitiveTrendusertype:(NSString*)value;

- (NSString*)primitiveUsername;
- (void)setPrimitiveUsername:(NSString*)value;

- (NSString*)primitiveUserphoto;
- (void)setPrimitiveUserphoto:(NSString*)value;

- (UserInfo*)primitiveUser;
- (void)setPrimitiveUser:(UserInfo*)value;

@end
