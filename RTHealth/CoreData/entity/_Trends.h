// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Trends.h instead.

#import <CoreData/CoreData.h>

extern const struct TrendsAttributes {
	__unsafe_unretained NSString *isfavorite;
	__unsafe_unretained NSString *ispublic;
	__unsafe_unretained NSString *trendclassify;
	__unsafe_unretained NSString *trendcommentnumber;
	__unsafe_unretained NSString *trendcontent;
	__unsafe_unretained NSString *trendfavoritenumber;
	__unsafe_unretained NSString *trendid;
	__unsafe_unretained NSString *trendphoto;
	__unsafe_unretained NSString *trendsharednumber;
	__unsafe_unretained NSString *trendtime;
	__unsafe_unretained NSString *trendtype;
	__unsafe_unretained NSString *useraddress;
	__unsafe_unretained NSString *userid;
	__unsafe_unretained NSString *usernickname;
	__unsafe_unretained NSString *userphoto;
	__unsafe_unretained NSString *usersex;
	__unsafe_unretained NSString *usertype;
} TrendsAttributes;

extern const struct TrendsRelationships {
	__unsafe_unretained NSString *comments;
	__unsafe_unretained NSString *favorite;
	__unsafe_unretained NSString *shared;
	__unsafe_unretained NSString *trendsofall;
	__unsafe_unretained NSString *trendsoffriend;
	__unsafe_unretained NSString *trendsoflike;
	__unsafe_unretained NSString *trendsofsports;
	__unsafe_unretained NSString *trendsofuser;
} TrendsRelationships;

@class Comment;
@class FriendsInfo;
@class FriendsInfo;
@class UserInfo;
@class UserInfo;
@class UserInfo;
@class UserInfo;
@class UserInfo;

@interface TrendsID : NSManagedObjectID {}
@end

@interface _Trends : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) TrendsID* objectID;

@property (nonatomic, strong) NSString* isfavorite;

//- (BOOL)validateIsfavorite:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* ispublic;

//- (BOOL)validateIspublic:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* trendclassify;

//- (BOOL)validateTrendclassify:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* trendcommentnumber;

//- (BOOL)validateTrendcommentnumber:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* trendcontent;

//- (BOOL)validateTrendcontent:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* trendfavoritenumber;

//- (BOOL)validateTrendfavoritenumber:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* trendid;

//- (BOOL)validateTrendid:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* trendphoto;

//- (BOOL)validateTrendphoto:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* trendsharednumber;

//- (BOOL)validateTrendsharednumber:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* trendtime;

//- (BOOL)validateTrendtime:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* trendtype;

//- (BOOL)validateTrendtype:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* useraddress;

//- (BOOL)validateUseraddress:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* userid;

//- (BOOL)validateUserid:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* usernickname;

//- (BOOL)validateUsernickname:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* userphoto;

//- (BOOL)validateUserphoto:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* usersex;

//- (BOOL)validateUsersex:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* usertype;

//- (BOOL)validateUsertype:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSSet *comments;

- (NSMutableSet*)commentsSet;

@property (nonatomic, strong) NSSet *favorite;

- (NSMutableSet*)favoriteSet;

@property (nonatomic, strong) NSSet *shared;

- (NSMutableSet*)sharedSet;

@property (nonatomic, strong) UserInfo *trendsofall;

//- (BOOL)validateTrendsofall:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) UserInfo *trendsoffriend;

//- (BOOL)validateTrendsoffriend:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) UserInfo *trendsoflike;

//- (BOOL)validateTrendsoflike:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) UserInfo *trendsofsports;

//- (BOOL)validateTrendsofsports:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) UserInfo *trendsofuser;

//- (BOOL)validateTrendsofuser:(id*)value_ error:(NSError**)error_;

@end

@interface _Trends (CommentsCoreDataGeneratedAccessors)
- (void)addComments:(NSSet*)value_;
- (void)removeComments:(NSSet*)value_;
- (void)addCommentsObject:(Comment*)value_;
- (void)removeCommentsObject:(Comment*)value_;

@end

@interface _Trends (FavoriteCoreDataGeneratedAccessors)
- (void)addFavorite:(NSSet*)value_;
- (void)removeFavorite:(NSSet*)value_;
- (void)addFavoriteObject:(FriendsInfo*)value_;
- (void)removeFavoriteObject:(FriendsInfo*)value_;

@end

@interface _Trends (SharedCoreDataGeneratedAccessors)
- (void)addShared:(NSSet*)value_;
- (void)removeShared:(NSSet*)value_;
- (void)addSharedObject:(FriendsInfo*)value_;
- (void)removeSharedObject:(FriendsInfo*)value_;

@end

@interface _Trends (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveIsfavorite;
- (void)setPrimitiveIsfavorite:(NSString*)value;

- (NSString*)primitiveIspublic;
- (void)setPrimitiveIspublic:(NSString*)value;

- (NSString*)primitiveTrendclassify;
- (void)setPrimitiveTrendclassify:(NSString*)value;

- (NSString*)primitiveTrendcommentnumber;
- (void)setPrimitiveTrendcommentnumber:(NSString*)value;

- (NSString*)primitiveTrendcontent;
- (void)setPrimitiveTrendcontent:(NSString*)value;

- (NSString*)primitiveTrendfavoritenumber;
- (void)setPrimitiveTrendfavoritenumber:(NSString*)value;

- (NSString*)primitiveTrendid;
- (void)setPrimitiveTrendid:(NSString*)value;

- (NSString*)primitiveTrendphoto;
- (void)setPrimitiveTrendphoto:(NSString*)value;

- (NSString*)primitiveTrendsharednumber;
- (void)setPrimitiveTrendsharednumber:(NSString*)value;

- (NSString*)primitiveTrendtime;
- (void)setPrimitiveTrendtime:(NSString*)value;

- (NSString*)primitiveTrendtype;
- (void)setPrimitiveTrendtype:(NSString*)value;

- (NSString*)primitiveUseraddress;
- (void)setPrimitiveUseraddress:(NSString*)value;

- (NSString*)primitiveUserid;
- (void)setPrimitiveUserid:(NSString*)value;

- (NSString*)primitiveUsernickname;
- (void)setPrimitiveUsernickname:(NSString*)value;

- (NSString*)primitiveUserphoto;
- (void)setPrimitiveUserphoto:(NSString*)value;

- (NSString*)primitiveUsersex;
- (void)setPrimitiveUsersex:(NSString*)value;

- (NSString*)primitiveUsertype;
- (void)setPrimitiveUsertype:(NSString*)value;

- (NSMutableSet*)primitiveComments;
- (void)setPrimitiveComments:(NSMutableSet*)value;

- (NSMutableSet*)primitiveFavorite;
- (void)setPrimitiveFavorite:(NSMutableSet*)value;

- (NSMutableSet*)primitiveShared;
- (void)setPrimitiveShared:(NSMutableSet*)value;

- (UserInfo*)primitiveTrendsofall;
- (void)setPrimitiveTrendsofall:(UserInfo*)value;

- (UserInfo*)primitiveTrendsoffriend;
- (void)setPrimitiveTrendsoffriend:(UserInfo*)value;

- (UserInfo*)primitiveTrendsoflike;
- (void)setPrimitiveTrendsoflike:(UserInfo*)value;

- (UserInfo*)primitiveTrendsofsports;
- (void)setPrimitiveTrendsofsports:(UserInfo*)value;

- (UserInfo*)primitiveTrendsofuser;
- (void)setPrimitiveTrendsofuser:(UserInfo*)value;

@end
