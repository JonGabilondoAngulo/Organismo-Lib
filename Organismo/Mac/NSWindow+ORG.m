//
//  NSWindow+ORG.m
//  Organismo-mac
//
//  Created by Jon Gabilondo on 09/07/2019.
//  Copyright © 2019 organismo-mobile. All rights reserved.
//

#import "NSWindow+ORG.h"

@implementation NSWindow (ORG)

- (NSString*)ORG_description {
    NSMutableString *description = [[NSMutableString alloc] initWithFormat:@"%@", NSStringFromClass(self.class)];
    if (self.title.length) {
        [description appendString:[NSString stringWithFormat:@" (%@)", self.title]];
    }
    if (!self.isVisible) {
        [description appendString:@" [Hidden]"];
    }
    return description;
}

@end
