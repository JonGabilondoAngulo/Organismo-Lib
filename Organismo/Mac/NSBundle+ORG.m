//
//  NSBundle+ORG.m
//  Organismo-mac
//
//  Created by Jon Gabilondo on 02/03/2020.
//  Copyright © 2020 organismo-mobile. All rights reserved.
//

#import "NSBundle+ORG.h"

#import <AppKit/AppKit.h>


@implementation NSBundle (ORG)

+ (NSBundle*)ORGFrameworkBundle {
    return [NSBundle bundleWithIdentifier: @"com.organismo-mobile.Organismo"];
}

@end
