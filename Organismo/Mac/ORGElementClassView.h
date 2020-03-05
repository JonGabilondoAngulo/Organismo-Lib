//
//  ORGElementClassView.h
//  Organismo-mac
//
//  Created by Jon Gabilondo on 12/09/2019.
//  Copyright © 2019 organismo-mobile. All rights reserved.
//

@import Cocoa;

NS_ASSUME_NONNULL_BEGIN

@class ORGUITreeNode;

@interface ORGElementClassView : NSView

- (void)showElement:(ORGUITreeNode*)node;

@end

NS_ASSUME_NONNULL_END
