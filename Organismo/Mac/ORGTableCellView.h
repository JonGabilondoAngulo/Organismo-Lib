/*
 Copyright (C) 2017 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information
 
 Abstract:
 A basic subclass of NSTableCellView that adds some properties strictly for allowing access to the items in code.
 */

@import Cocoa;
@class ORGUITreeNode;

@interface ORGTableCellView : NSTableCellView

@property (weak) ORGUITreeNode *treeNode;
@property (assign) BOOL selected;

@end
