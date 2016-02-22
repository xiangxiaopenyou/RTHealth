// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Entity.h instead.

#import <CoreData/CoreData.h>

extern const struct EntityAttributes {
	__unsafe_unretained NSString *attribute;
} EntityAttributes;

extern const struct EntityRelationships {
	__unsafe_unretained NSString *relationship;
} EntityRelationships;

@class Entity1;

@interface EntityID : NSManagedObjectID {}
@end

@interface _Entity : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) EntityID* objectID;

@property (nonatomic, strong) NSString* attribute;

//- (BOOL)validateAttribute:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSSet *relationship;

- (NSMutableSet*)relationshipSet;

@end

@interface _Entity (RelationshipCoreDataGeneratedAccessors)
- (void)addRelationship:(NSSet*)value_;
- (void)removeRelationship:(NSSet*)value_;
- (void)addRelationshipObject:(Entity1*)value_;
- (void)removeRelationshipObject:(Entity1*)value_;

@end

@interface _Entity (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveAttribute;
- (void)setPrimitiveAttribute:(NSString*)value;

- (NSMutableSet*)primitiveRelationship;
- (void)setPrimitiveRelationship:(NSMutableSet*)value;

@end
