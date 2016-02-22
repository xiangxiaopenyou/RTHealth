// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Comment.h instead.

#import <CoreData/CoreData.h>

extern const struct CommentAttributes {
	__unsafe_unretained NSString *commentcontent;
	__unsafe_unretained NSString *commentid;
	__unsafe_unretained NSString *commenttime;
	__unsafe_unretained NSString *commenttouserid;
	__unsafe_unretained NSString *commenttousername;
	__unsafe_unretained NSString *commentuserid;
	__unsafe_unretained NSString *commentusername;
	__unsafe_unretained NSString *commentuserphoto;
} CommentAttributes;

extern const struct CommentRelationships {
	__unsafe_unretained NSString *trend;
} CommentRelationships;

@class Trends;

@interface CommentID : NSManagedObjectID {}
@end

@interface _Comment : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) CommentID* objectID;

@property (nonatomic, strong) NSString* commentcontent;

//- (BOOL)validateCommentcontent:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* commentid;

//- (BOOL)validateCommentid:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* commenttime;

//- (BOOL)validateCommenttime:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* commenttouserid;

//- (BOOL)validateCommenttouserid:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* commenttousername;

//- (BOOL)validateCommenttousername:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* commentuserid;

//- (BOOL)validateCommentuserid:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* commentusername;

//- (BOOL)validateCommentusername:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* commentuserphoto;

//- (BOOL)validateCommentuserphoto:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) Trends *trend;

//- (BOOL)validateTrend:(id*)value_ error:(NSError**)error_;

@end

@interface _Comment (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveCommentcontent;
- (void)setPrimitiveCommentcontent:(NSString*)value;

- (NSString*)primitiveCommentid;
- (void)setPrimitiveCommentid:(NSString*)value;

- (NSString*)primitiveCommenttime;
- (void)setPrimitiveCommenttime:(NSString*)value;

- (NSString*)primitiveCommenttouserid;
- (void)setPrimitiveCommenttouserid:(NSString*)value;

- (NSString*)primitiveCommenttousername;
- (void)setPrimitiveCommenttousername:(NSString*)value;

- (NSString*)primitiveCommentuserid;
- (void)setPrimitiveCommentuserid:(NSString*)value;

- (NSString*)primitiveCommentusername;
- (void)setPrimitiveCommentusername:(NSString*)value;

- (NSString*)primitiveCommentuserphoto;
- (void)setPrimitiveCommentuserphoto:(NSString*)value;

- (Trends*)primitiveTrend;
- (void)setPrimitiveTrend:(Trends*)value;

@end
