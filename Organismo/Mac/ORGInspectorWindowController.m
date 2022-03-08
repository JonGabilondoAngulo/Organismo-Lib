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
#import "ORGUITreeViewController.h"
#import "ORGLibrariesViewController.h"
#import "ORGClassesViewController.h"
#import "ORGViewContainer.h"
#import "NSBundle+ORG.h"
#import "NSStoryboard+ORG.h"

@import Quartz;

@interface ORGInspectorWindowController ()
@property (nonatomic) ORGUITreeViewController *uiTreeViewController;
@property (nonatomic) ORGLibrariesViewController *librariesViewController;
@property (nonatomic) ORGClassesViewController *classesViewController;
@end

@implementation ORGInspectorWindowController

- (NSString *)windowNibName {
    return @"ORGInspectorWindowController";
}

- (void)windowDidLoad {
    [super windowDidLoad];
    
    [self uiTreeSelection:nil];
}

#pragma mark - Toobar Actions

- (IBAction)uiTreeSelection:(id)sender {
    if (!self.uiTreeViewController) {
        self.uiTreeViewController = (ORGUITreeViewController*)[NSStoryboard ORG_instantiateControllerWithIdentifier:@"ORGUITreeViewController"];
    }
    ORGViewContainer *container = (ORGViewContainer*)self.contentViewController.view;
    [container addSubviewOfController:self.uiTreeViewController];
}

- (IBAction)librariesSelection:(id)sender {
    if (!self.librariesViewController) {
        self.librariesViewController = (ORGLibrariesViewController*)[NSStoryboard ORG_instantiateControllerWithIdentifier:@"ORGLibrariesViewController"];
    }
    ORGViewContainer *container = (ORGViewContainer*)self.contentViewController.view;
    [container addSubviewOfController:self.librariesViewController];
}

- (IBAction)classesSelection:(id)sender {
    if (!self.classesViewController) {
        self.classesViewController = (ORGClassesViewController*)[NSStoryboard ORG_instantiateControllerWithIdentifier:@"ORGClassesViewController"];
        self.classesViewController.loadMainBundleClassNamesReady = YES;
    }
    ORGViewContainer *container = (ORGViewContainer*)self.contentViewController.view;
    [container addSubviewOfController:self.classesViewController];
}

#pragma mark - NSWindowDelegate

- (void)windowWillClose:(NSNotification *)notification {
}


@end
