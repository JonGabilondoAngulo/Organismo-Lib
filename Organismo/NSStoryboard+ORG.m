//
//  NSStoryboard+ORG.m
//  Organismo-mac
//
//  Created by Jon Gabilondo on 08/03/2022.
//  Copyright © 2022 organismo-mobile. All rights reserved.
//

#import "NSStoryboard+ORG.h"
#import "NSBundle+ORG.h"

@implementation NSStoryboard (ORG)

+ (NSStoryboard*)ORG_storyboard {
    return [NSStoryboard storyboardWithName:@"Organismo-mac" bundle:[NSBundle ORGFrameworkBundle]];
}

+ (NSWindowController*)ORG_instantiateInitialController {
    NSStoryboard *sb = [NSStoryboard ORG_storyboard];
    return [sb instantiateInitialController];
}

+ (NSViewController*)ORG_instantiateControllerWithIdentifier:(NSString*)identifier{
    NSStoryboard *sb = [NSStoryboard ORG_storyboard];
    return [sb instantiateControllerWithIdentifier:identifier];
}


@end
