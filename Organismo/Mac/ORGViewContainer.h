//
//  ORGViewContainer.h
//  Organismo-mac
//
//  Created by Jon Gabilondo on 08/03/2022.
//  Copyright © 2022 organismo-mobile. All rights reserved.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface ORGViewContainer : NSView

- (void)addSubviewOfController:(NSViewController*)controller;

@end

NS_ASSUME_NONNULL_END
