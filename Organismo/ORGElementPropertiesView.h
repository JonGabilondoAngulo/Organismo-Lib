//
//  ORGElementPropertiesView.h
//  Organismo-mac
//
//  Created by Jon Gabilondo on 12/09/2019.
//  Copyright © 2019 organismo-mobile. All rights reserved.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@class ORGUITreeNode;

@interface ORGElementPropertiesView : NSView <NSTextFieldDelegate>

- (void)showElement:(ORGUITreeNode*)node;

@end

NS_ASSUME_NONNULL_END
