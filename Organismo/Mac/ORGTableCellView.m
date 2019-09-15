/*
 Copyright (C) 2017 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information
 
 Abstract:
 A basic subclass of NSTableCellView that adds some properties strictly for allowing access to the items in code.
 */

#import "ORGTableCellView.h"

@interface ORGTableCellView ()

@property (assign) BOOL isSmallSize;
@property (nonatomic) BOOL mouseInside;
@property (nonatomic) NSTrackingArea * trackingArea;

@end

#pragma mark -

@implementation ORGTableCellView

- (void)layoutViewsForSmallSize:(BOOL)smallSize animated:(BOOL)animated {
    if (self.isSmallSize != smallSize) {
        _isSmallSize = smallSize;
        CGFloat targetAlpha = self.isSmallSize ? 0 : 1;
        if (animated) {
            self.subTitleTextField.animator.alphaValue = targetAlpha;
        } else {
            self.subTitleTextField.alphaValue = targetAlpha;
        }
    }
}

- (void)ensureTrackingArea {
    if (_trackingArea == nil) {
        _trackingArea = [[NSTrackingArea alloc] initWithRect:NSZeroRect options:NSTrackingInVisibleRect | NSTrackingActiveAlways | NSTrackingMouseEnteredAndExited owner:self userInfo:nil];
    }
}

- (void)updateTrackingAreas {
    [super updateTrackingAreas];
    [self ensureTrackingArea];
    if (![[self trackingAreas] containsObject:_trackingArea]) {
        [self addTrackingArea:_trackingArea];
    }
}

- (void)mouseEntered:(NSEvent *)theEvent {
    self.mouseInside = YES;
    self.needsDisplay = YES;
    if (!_selected) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"HIGHLIGHT-ELEMENT" object:self];
    }
}

- (void)mouseExited:(NSEvent *)theEvent {
    self.mouseInside = NO;
    self.needsDisplay = YES;
    if (!_selected) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"REMOVE-HIGHLIGHT" object:nil];
    }
}

- (void)drawRect:(NSRect)dirtyRect {
    if (self.mouseInside) {
        [NSGraphicsContext saveGraphicsState];
        [[NSColor lightGrayColor] set];
        NSRectFill([self bounds]);
        [NSGraphicsContext restoreGraphicsState];
    } else {
        [super drawRect:dirtyRect];
    }
}

@end
