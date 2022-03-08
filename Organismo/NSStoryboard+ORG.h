//
//  NSStoryboard+ORG.h
//  Organismo-mac
//
//  Created by Jon Gabilondo on 08/03/2022.
//  Copyright © 2022 organismo-mobile. All rights reserved.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSStoryboard (ORG)

+ (NSStoryboard*)ORG_storyboard;
+ (NSWindowController*)ORG_instantiateInitialController;
+ (NSViewController*)ORG_instantiateControllerWithIdentifier:(NSString*)identifier;

@end

NS_ASSUME_NONNULL_END
