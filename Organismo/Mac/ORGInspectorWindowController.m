//
//  ORGInspectorWindowController.m
//  Organismo-mac
//
//  Created by Jon Gabilondo on 08/07/2019.
//  Copyright © 2019 organismo-mobile. All rights reserved.
//

#import "ORGInspectorWindowController.h"
#import "ORGElementPropertiesView.h"
#import "ORGElementClassView.h"
#import "ORGUITree.h"
#import "ORGUITreeNode.h"
#import "ORGNSViewHierarchy.h"
#import "ORGTableCellView.h"
#import <Quartz/Quartz.h>

@interface ORGInspectorWindowController ()

@property (weak) IBOutlet NSTabView *tabView;
@property (weak) IBOutlet NSOutlineView *outlineView;
@property (weak) IBOutlet ORGElementPropertiesView *propertiesView;
@property (nonatomic) ORGUITree *tree;
@property (nonatomic) CAShapeLayer *highlightLayer;
@property (weak) IBOutlet ORGElementClassView *classView;

@end

@implementation ORGInspectorWindowController

- (NSString *)windowNibName {
    return @"ORGInspectorWindowController";
}

- (void)windowDidLoad {
    [super windowDidLoad];
}

#pragma mark - NSWindowDelegate

- (void)windowWillClose:(NSNotification *)notification {
    self.tree = nil;
}

#pragma mark - NSOutlineView

- (NSInteger)outlineView:(NSOutlineView *)outlineView numberOfChildrenOfItem:(id)item {
    if (item == nil) {
        return self.tree.windows.count;
    } else if ([item isKindOfClass:[ORGUITreeNode class]]) {
        ORGUITreeNode *node = item;
        return node.children.count;
    } else {
        return 0;
    }
}

- (id)outlineView:(NSOutlineView *)outlineView child:(NSInteger)index ofItem:(id)item {
    if (item == nil) {
        return (self.tree.windows)[index];
    } else if ([item isKindOfClass:[ORGUITreeNode class]]) {
        ORGUITreeNode *node = item;
        return node.children[index];
    } else {
        return nil;
    }
}

- (BOOL)outlineView:(NSOutlineView *)outlineView isItemExpandable:(id)item {
    if ([item isKindOfClass:[ORGUITreeNode class]]) {
        ORGUITreeNode *node = item;
        return node.children.count;
        //return [node.view isKindOfClass:[NSWindow class]];
    }
    return NO;
}

- (id)outlineView:(NSOutlineView *)outlineView objectValueForTableColumn:(NSTableColumn *)tableColumn byItem:(id)item {
    return item;
}

- (BOOL)outlineView:(NSOutlineView *)outlineView isGroupItem:(id)item {
    return NO;
}

- (NSView *)outlineView:(NSOutlineView *)outlineView viewForTableColumn:(NSTableColumn *)tableColumn item:(id)item {
    ORGTableCellView *view;
    
    if ([item isKindOfClass:[ORGUITreeNode class]]) {
        ORGUITreeNode *node = item;
        //if ([node.uiElement isKindOfClass:[NSWindow class]]) {
        //    view = [outlineView makeViewWithIdentifier:@"WindowCell" owner:self];
        //} else {
            view = [outlineView makeViewWithIdentifier:@"MainCell" owner:self];
        //}
        view.treeNode = item;
    }
    return view;
}

- (void)outlineViewSelectionDidChange:(NSNotification*)notification {
    
    NSOutlineView *table = notification.object;
        
    self.selectedNode = [table itemAtRow:[table selectedRow]];
//    if (self.selectedNode.isHidden) {
//        self.selectedNode = nil;
//    }
    [self.propertiesView showElement:self.selectedNode];
    [self.classView showElement:self.selectedNode];
}


@end
