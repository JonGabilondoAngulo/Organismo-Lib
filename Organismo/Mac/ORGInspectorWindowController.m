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
#import "NSBundle+ORG.h"
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
    
    self.uiTreeViewController = (ORGUITreeViewController*)self.contentViewController;
}

#pragma mark - Toobar Actions

- (IBAction)uiTreeSelection:(id)sender {
    self.contentViewController = self.uiTreeViewController;
}

- (IBAction)librariesSelection:(id)sender {
    if (!self.librariesViewController) {
        NSStoryboard *sb = [NSStoryboard storyboardWithName:@"Organismo-mac" bundle:[NSBundle ORGFrameworkBundle]];
        self.librariesViewController = [sb instantiateControllerWithIdentifier:@"ORGLibrariesViewController"];
    }
    self.contentViewController = self.librariesViewController;
}

- (IBAction)classesSelection:(id)sender {
    if (!self.classesViewController) {
        self.classesViewController = [[ORGClassesViewController alloc] initWithNibName:@"ORGClassesViewController" bundle:[NSBundle ORGFrameworkBundle]];
        self.classesViewController.loadMainBundleClassNamesWhenReady = YES;
    }
    self.contentViewController = self.classesViewController;
}

#pragma mark - NSWindowDelegate

- (void)windowWillClose:(NSNotification *)notification {
}


@end
