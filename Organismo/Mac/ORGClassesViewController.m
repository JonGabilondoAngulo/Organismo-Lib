//
//  ORGClassesViewController.m
//  Organismo-mac
//
//  Created by Jon Gabilondo on 05/03/2020.
//  Copyright © 2020 organismo-mobile. All rights reserved.
//

#import "ORGClassesViewController.h"
#import "NSBundle+ORG.h"
#import <objc/runtime.h>

@interface ORGClassesViewController ()
@property (strong) IBOutlet NSTreeController *classesTreeController;
@property (weak) IBOutlet NSOutlineView *outlineView;
@end

static NSImage *thumbnailClass;
static NSImage *thumbnailMethod;
static NSImage *thumbnailProperty;

@implementation ORGClassesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.loadMainBundleClassNamesWhenReady) {
        [self loadMainBundleClassNames];
        self.loadMainBundleClassNamesWhenReady = NO;
    }
}

- (void)loadImageClassNames:(NSString*)imageName {
    
    self.classesTreeController.content = [NSMutableArray array]; // Reseting. Not a better way ?

    // Based on FLEX https://github.com/Flipboard/FLEX
    unsigned int classNamesCount = 0;
    const char **classNames = objc_copyClassNamesForImage(imageName.UTF8String, &classNamesCount);
    if (classNames) {
        for (unsigned int i = 0; i < classNamesCount; i++) {
            const char *className = classNames[i];
            NSString *classNameString = [NSString stringWithUTF8String:className];
            Class class = objc_getClass(classNameString.UTF8String);
            NSArray<NSDictionary *> *properties = [self propertiesForClass:class];
            NSArray<NSDictionary *> *methods = [self methodsForClass:class];
            NSMutableArray<NSDictionary *> *children = [NSMutableArray arrayWithArray:properties];
            [children addObjectsFromArray:methods];
            [self.classesTreeController addObject:@{@"name":classNameString, @"image":[self thumbnailImageForClass], @"children":children}];
        }
        free(classNames);
    }
}

- (void)loadMainBundleClassNames {
    [self loadImageClassNames:[NSBundle mainBundle].executablePath];
}

- (void)showClass:(Class)aClass {
    self.classesTreeController.content = [NSMutableArray array]; // Reseting. Not a better way ?

    NSString *classNameString = NSStringFromClass(aClass);
    if (classNameString == nil) {
        NSLog(@"Unknown class. %@", aClass);
        return;
    }
    NSArray<NSDictionary *> *properties = [self propertiesForClass:aClass];
    NSArray<NSDictionary *> *methods = [self methodsForClass:aClass];
    NSMutableArray<NSDictionary *> *children = [NSMutableArray arrayWithArray:properties];
    [children addObjectsFromArray:methods];
    [self.classesTreeController addObject:@{@"name":classNameString, @"image":[self thumbnailImageForClass], @"children":children}];
    
    [self.outlineView expandItem:[self.outlineView itemAtRow:0]];

}

- (NSArray<NSDictionary *> *)propertiesForClass:(Class)class {
    // Based on FLEX https://github.com/Flipboard/FLEX
    NSMutableArray<NSDictionary *> *properties = [NSMutableArray array];
    unsigned int propertyCount = 0;
    objc_property_t *propertyList = class_copyPropertyList(class, &propertyCount);
    if (propertyList) {
        for (unsigned int i = 0; i < propertyCount; i++) {
            objc_property_t property = propertyList[i];
            NSString *name = @(property_getName(property));
            [properties addObject:@{@"name": name, @"image": [self thumbnailImageForProperty], @"children":@[]}];
        }
        free(propertyList);
    }
    return properties;
}

- (NSArray<NSDictionary *> *)methodsForClass:(Class)class {
    // Based on FLEX https://github.com/Flipboard/FLEX
    NSMutableArray<NSDictionary *> *methods = [NSMutableArray array];
    unsigned int methodCount = 0;
    Method *methodList = class_copyMethodList(class, &methodCount);
    if (methodList) {
        for (unsigned int i = 0; i < methodCount; i++) {
            Method method = methodList[i];
            NSString *name = NSStringFromSelector(method_getName(method));
            [methods addObject:@{@"name": name, @"image": [self thumbnailImageForMethod], @"children":@[]}];
        }
        free(methodList);
    }
    return methods;
}

- (NSImage*)thumbnailImageForClass {
    if (!thumbnailClass) {
        NSBundle *orgFramework = [NSBundle ORGFrameworkBundle];
        thumbnailClass = [orgFramework imageForResource:@"class_16x16_Normal"];
    }
    return thumbnailClass;
}

- (NSImage*)thumbnailImageForMethod {
    if (!thumbnailMethod) {
        NSBundle *orgFramework = [NSBundle ORGFrameworkBundle];
        thumbnailMethod = [orgFramework imageForResource:@"method_16x16_Normal"];
    }
    return thumbnailMethod;
}

- (NSImage*)thumbnailImageForProperty {
    if (!thumbnailProperty) {
        NSBundle *orgFramework = [NSBundle ORGFrameworkBundle];
        return [orgFramework imageForResource:@"property_16x16_Normal"];
    }
    return thumbnailProperty;
}
@end
