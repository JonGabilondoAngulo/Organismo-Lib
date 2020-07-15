//
//  ORGUITreeViewController.h
//  Organismo-mac
//
//  Created by Jon Gabilondo on 27/02/2020.
//  Copyright © 2020 organismo-mobile. All rights reserved.
//

@import Cocoa;

NS_ASSUME_NONNULL_BEGIN

@class ORGUITreeNode;

@interface ORGUITreeViewController : NSViewController <NSOutlineViewDataSource, NSOutlineViewDelegate>

@property (nonatomic, nullable) ORGUITreeNode *selectedNode;

@end

NS_ASSUME_NONNULL_END
