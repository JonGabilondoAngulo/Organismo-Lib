//
//  ORGElementPropertiesView.m
//  Organismo-mac
//
//  Created by Jon Gabilondo on 12/09/2019.
//  Copyright © 2019 organismo-mobile. All rights reserved.
//

#import "ORGElementPropertiesView.h"
#import "ORGUITreeNode.h"

@interface ORGElementPropertiesView()

@property (weak) IBOutlet NSTextField *rectX;
@property (weak) IBOutlet NSTextField *rectW;
@property (weak) IBOutlet NSTextField *rectY;
@property (weak) IBOutlet NSTextField *rectH;
@property (weak) IBOutlet NSButton *hiddenButton;

@property (nonatomic) ORGUITreeNode *node;

- (void)updateFrame;

@end


@implementation ORGElementPropertiesView

- (void)showElement:(ORGUITreeNode*)node {
    self.node = node;
    
    if (node) {
        NSRect rect = node.rect;
        self.rectX.integerValue = rect.origin.x;
        self.rectY.integerValue = rect.origin.y;
        self.rectW.integerValue = rect.size.width;
        self.rectH.integerValue = rect.size.height;
        self.hiddenButton.intValue = node.isHidden;
    } else {
        self.rectX.stringValue = @"";
        self.rectY.stringValue = @"";
        self.rectW.stringValue = @"";
        self.rectH.stringValue = @"";
        self.hiddenButton.intValue = NO;
    }
}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}

- (IBAction)hiddenSelected:(NSButton *)sender {
    if ([self.node.uiElement isKindOfClass:NSView.class]) {
        NSView *view = (NSView*)self.node.uiElement;
        view.hidden = sender.intValue;
    }
}

- (IBAction)rectXChanged:(NSStepper *)sender {
    [self updateFrame];
}

- (IBAction)rectYChanged:(NSStepper *)sender {
    [self updateFrame];
}

- (IBAction)rectWChanged:(NSStepper *)sender {
    [self updateFrame];
}

- (IBAction)rectHChanged:(NSStepper *)sender {
    [self updateFrame];
}

- (void)updateFrame {
    if ([self.node.uiElement isKindOfClass:NSWindow.class]) {
        NSWindow *window = (NSWindow*)self.node.uiElement;
        if (window.visible) {
            [window setFrame:NSMakeRect(self.rectX.integerValue, self.rectY.integerValue, self.rectW.integerValue, self.rectH.integerValue) display:YES animate:YES];
        }
    } else if ([self.node.uiElement isKindOfClass:NSView.class]) {
        NSView *view = (NSView*)self.node.uiElement;
        if (view.isHidden == NO) {
            view.frame = NSMakeRect(self.rectX.integerValue, self.rectY.integerValue, self.rectW.integerValue, self.rectH.integerValue);
        }
    }
}

#pragma mark NSTextFieldDelegate

- (void)controlTextDidEndEditing:(NSNotification *)obj {
    [self updateFrame];
}

- (void)controlTextDidChange:(NSNotification *)obj {
    
}

@end
