//
//  ORGElementClassView.m
//  Organismo-mac
//
//  Created by Jon Gabilondo on 12/09/2019.
//  Copyright © 2019 organismo-mobile. All rights reserved.
//

#import "ORGElementClassView.h"
#import "ORGUITreeNode.h"
#import <objc/runtime.h>

@interface ORGElementClassView()

@property (weak) IBOutlet NSTableView *methodsTableView;
@property (strong) IBOutlet NSArrayController *methodsArrayController;

@property (nonatomic) ORGUITreeNode *node;
@property (nonatomic) NSMutableArray<NSString*> *methods;
@property (nonatomic) NSArray<NSString*> *classHierarchy;

- (NSArray*)buildClassHierarchy:(Class)class;
- (void)showClass:(Class)class;
@end

@implementation ORGElementClassView

- (void)showElement:(ORGUITreeNode*)node {
    
    self.node = node;
    self.classHierarchy = [self buildClassHierarchy:node.uiElement.class];
    [self showClass:node.uiElement.class];
}

- (NSArray*)buildClassHierarchy:(Class)class {
    NSMutableArray *hierarchy = [NSMutableArray array];
    for ( Class currentClass = class; currentClass; currentClass = currentClass.superclass) {
        [hierarchy addObject:NSStringFromClass(currentClass)];
    }
    return hierarchy;
}

- (IBAction)hierarchyPathChanged:(NSPopUpButton *)sender {
    
    NSString *className = self.classHierarchy[sender.indexOfSelectedItem];
    if (!className) {
        return;
    }
    [self showClass:NSClassFromString(className)];
}

- (void)showClass:(Class)class {
    
    if (self.methods) {
        [self.methodsArrayController removeObjects:self.methods];
    } else {
        self.methods = [NSMutableArray array];
        self.methodsArrayController.content = self.methods;
    }
    
    unsigned int classCount;
    Method *methodsList = class_copyMethodList(class, &classCount);
    for (unsigned int i = 0; i < classCount; i++) {
        SEL selector = method_getName(methodsList[i]);
        [self.methodsArrayController addObject:NSStringFromSelector(selector)];
    }
    free(methodsList);
        
    [self.methodsTableView reloadData];
}

@end
