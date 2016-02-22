// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Entity1.h instead.

#import <CoreData/CoreData.h>

extern const struct Entity1Attributes {
	__unsafe_unretained NSString *attribute;
} Entity1Attributes;

extern const struct Entity1Relationships {
	__unsafe_unretained NSString *relationship;
} Entity1Relationships;

@class Entity;

@interface Entity1ID : NSManagedObjectID {}
@end

@interface _Entity1 : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) Entity1ID* objectID;

@property (nonatomic, strong) NSString* attribute;

//- (BOOL)validateAttribute:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) Entity *relationship;

//- (BOOL)validateRelationship:(id*)value_ error:(NSError**)error_;

@end

@interface _Entity1 (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveAttribute;
- (void)setPrimitiveAttribute:(NSString*)value;

- (Entity*)primitiveRelationship;
- (void)setPrimitiveRelationship:(Entity*)value;

@end
