//
//  ORGElementClassView.m
//  Organismo-mac
//
//  Created by Jon Gabilondo on 12/09/2019.
//  Copyright © 2019 organismo-mobile. All rights reserved.
//

#import "ORGElementClassView.h"
#import "ORGUITreeNode.h"
#import "ORGClassesViewController.h"

@interface ORGElementClassView()

//@property (weak) IBOutlet NSTableView *methodsTableView;
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
    if (!self.classHierarchyArrayController.content) {
        self.classHierarchyArrayController.content = [NSMutableArray array]; 
    }
    [self.classHierarchyArrayController removeObjects:[self.classHierarchyArrayController arrangedObjects]];
    for ( Class currentClass = class; currentClass; currentClass = currentClass.superclass) {
        [self.classHierarchyArrayController addObject:NSStringFromClass(currentClass)];
    }
}

- (void)showClassMethods:(Class)class {
    [self.classesViewController showClass:class];
 }

@end
