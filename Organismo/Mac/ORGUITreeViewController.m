//
//  ORGUITreeViewController.m
//  Organismo-mac
//
//  Created by Jon Gabilondo on 27/02/2020.
//  Copyright © 2020 organismo-mobile. All rights reserved.
//

#import "ORGUITreeViewController.h"
#import "ORGUITree.h"
#import "ORGUITreeNode.h"
#import "ORGNSViewHierarchy.h"
#import "ORGTableCellView.h"
#import "ORGElementPropertiesView.h"
#import "ORGElementClassView.h"
#import "ORGClassesViewController.h"
#import "ORGViewContainer.h"
#import "NSBundle+ORG.h"
#import "NSStoryboard+ORG.h"
@import Quartz;

@interface ORGUITreeViewController ()

@property (weak) IBOutlet NSTabView *tabView;
@property (weak) IBOutlet NSOutlineView *outlineView;
@property (weak) IBOutlet ORGElementPropertiesView *propertiesView;
@property (weak) IBOutlet ORGElementClassView *classView;
@property (weak) IBOutlet ORGViewContainer *classViewContainer;
@property (nonatomic) ORGUITree *tree;
@property (nonatomic) CAShapeLayer *highlightLayer;
@property (nonatomic) ORGClassesViewController *classesViewController;

- (void)removeHighlight:(NSNotification*)notitication;
- (void)highlightItem:(NSNotification*)notitication;

@end

@implementation ORGUITreeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    NSArray<NSWindow*> *windows = [ORGNSViewHierarchy appWindows:NSApp];

    self.tree = [[ORGUITree alloc] init];
    self.tree.windows = [[NSMutableArray alloc] init];
    for (NSWindow *window in windows) {
        [self.tree.windows addObject:[[ORGUITreeNode alloc] initWithView:(NSView*)window]];
    }
    for (ORGUITreeNode *node in self.tree.windows) {
        [ORGNSViewHierarchy childNodes:node skipPrivateClasses:NO screenshots:NO recursive:YES];
    }

    [self.outlineView reloadData];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(highlightItem:) name:@"HIGHLIGHT-ELEMENT" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(removeHighlight:) name:@"REMOVE-HIGHLIGHT" object:nil];
    
    // Install Methods view
    self.classesViewController = (ORGClassesViewController*)[NSStoryboard ORG_instantiateControllerWithIdentifier:@"ORGClassesViewController"];

    [self.classViewContainer addSubviewOfController:self.classesViewController];
    [self addChildViewController:self.classesViewController];

    self.classView.classesViewController = self.classesViewController;
}

- (void)removeHighlight:(NSNotification*)notitication {
    if (_highlightLayer) {
        [_highlightLayer removeFromSuperlayer];
        _highlightLayer = nil;
    }
}

- (void)highlightItem:(NSNotification*)notitication {
    NSView *view;
    
    ORGTableCellView *cell = notitication.object;
    NSAssert(cell, @"Missing object in notification.");
    ORGUITreeNode *node = cell.treeNode;
    NSAssert(node, @"Missing object in notification.");

    if ([node.uiElement isKindOfClass:NSWindow.class]) {
        NSWindow *window = (NSWindow*)node.uiElement;
        if (window.visible) {
            view = window.contentView;
        }
    } else {
        view = (NSView*)node.uiElement;
        if (view.hidden) {
            view = nil;
        }
    }
    
    if (view) {
        _highlightLayer = [CAShapeLayer layer];
        _highlightLayer.bounds = view.bounds;
        _highlightLayer.lineWidth = 4;
        _highlightLayer.fillColor = CGColorCreateGenericRGB(0.0, 0.0, 0.0, 0.0);
        _highlightLayer.strokeColor = CGColorCreateGenericRGB(1.0, 0.5, 0.5, 1.0);
        _highlightLayer.anchorPoint = CGPointMake(0.0f, 0.0f);

        CGMutablePathRef path = CGPathCreateMutable();
        CGPathAddRect(path, nil, _highlightLayer.bounds);
        _highlightLayer.path = path;
        if (!view.layer) {
            [view setLayer:[CALayer new]];
            [view setWantsLayer:YES];
        }
        NSAssert(view.layer, @"No CALayer for view. %@", view);
        [view.layer addSublayer:_highlightLayer];
        [_highlightLayer display];
    }
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
        //ORGUITreeNode *node = item;
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

#pragma mark - Actions


- (IBAction)elementViewSelection:(NSSegmentedControl *)sender {
    [self.tabView selectTabViewItemAtIndex:sender.selectedSegment];
}

@end
