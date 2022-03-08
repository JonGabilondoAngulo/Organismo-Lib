//
//  ORGViewContainer.m
//  Organismo-mac
//
//  Created by Jon Gabilondo on 08/03/2022.
//  Copyright © 2022 organismo-mobile. All rights reserved.
//

#import "ORGViewContainer.h"

@interface ORGViewContainer()
@property (nonatomic) NSView *currentSubview;
@end

@implementation ORGViewContainer

- (void)addSubviewOfController:(NSViewController*)controller
{
    NSView *view = controller.view;
    
    if (self.currentSubview) {
        [self.currentSubview  removeFromSuperview];
        self.currentSubview = nil;
    }
    
    [self addSubview:controller.view];
    [view setFrameOrigin:NSZeroPoint];
    [view setFrameSize:self.frame.size];
    
    self.currentSubview = view;
 }


@end
