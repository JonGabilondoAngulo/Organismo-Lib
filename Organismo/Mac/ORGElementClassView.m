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
@property (strong) IBOutlet NSArrayController *classHierarchyArrayController;
@property (nonatomic) ORGUITreeNode *node;

- (void)showClassHierarchy:(Class)class;
- (void)showClassMethods:(Class)class;
@end

@implementation ORGElementClassView

- (void)showElement:(ORGUITreeNode*)node {
    
    self.node = node;
    [self showClassHierarchy:node.uiElement.class];
    [self showClassMethods:node.uiElement.class];
}

- (IBAction)hierarchyPathChanged:(NSPopUpButton *)sender {
    
    NSString *className = [self.classHierarchyArrayController arrangedObjects][[sender indexOfSelectedItem]];
    if (!className) {
        return;
    }
    [self showClassMethods:NSClassFromString(className)];
}

- (void)showClassHierarchy:(Class)class {
    [self.classHierarchyArrayController removeObjects:[self.classHierarchyArrayController arrangedObjects]];
    for ( Class currentClass = class; currentClass; currentClass = currentClass.superclass) {
        [self.classHierarchyArrayController addObject:NSStringFromClass(currentClass)];
    }
}

- (void)showClassMethods:(Class)class {
    [self.methodsArrayController removeObjects:[self.methodsArrayController arrangedObjects]];
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
