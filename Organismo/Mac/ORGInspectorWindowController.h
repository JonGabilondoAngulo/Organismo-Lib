//
//  ORGInspectorWindowController.h
//  Organismo-mac
//
//  Created by Jon Gabilondo on 08/07/2019.
//  Copyright © 2019 organismo-mobile. All rights reserved.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@class ORGUITreeNode;

@interface ORGInspectorWindowController : NSWindowController <NSWindowDelegate>

@property (nonatomic, nullable) ORGUITreeNode *selectedNode;


@end

NS_ASSUME_NONNULL_END
