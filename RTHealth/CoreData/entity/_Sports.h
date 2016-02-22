// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Sports.h instead.

#import <CoreData/CoreData.h>

extern const struct SportsAttributes {
	__unsafe_unretained NSString *sportid;
	__unsafe_unretained NSString *sportname;
	__unsafe_unretained NSString *sportphoto;
} SportsAttributes;

extern const struct SportsRelationships {
	__unsafe_unretained NSString *favouritesport;
	__unsafe_unretained NSString *friendfavourite;
} SportsRelationships;

@class UserInfo;
@class FriendsInfo;

@interface SportsID : NSManagedObjectID {}
@end

@interface _Sports : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) SportsID* objectID;

@property (nonatomic, strong) NSString* sportid;

//- (BOOL)validateSportid:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* sportname;

//- (BOOL)validateSportname:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* sportphoto;

//- (BOOL)validateSportphoto:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) UserInfo *favouritesport;

//- (BOOL)validateFavouritesport:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) FriendsInfo *friendfavourite;

//- (BOOL)validateFriendfavourite:(id*)value_ error:(NSError**)error_;

@end

@interface _Sports (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveSportid;
- (void)setPrimitiveSportid:(NSString*)value;

- (NSString*)primitiveSportname;
- (void)setPrimitiveSportname:(NSString*)value;

- (NSString*)primitiveSportphoto;
- (void)setPrimitiveSportphoto:(NSString*)value;

- (UserInfo*)primitiveFavouritesport;
- (void)setPrimitiveFavouritesport:(UserInfo*)value;

- (FriendsInfo*)primitiveFriendfavourite;
- (void)setPrimitiveFriendfavourite:(FriendsInfo*)value;

@end
