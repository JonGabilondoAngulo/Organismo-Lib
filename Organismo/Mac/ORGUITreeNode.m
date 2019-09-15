//
//  ORGUITreeNode.m
//  Organismo-mac
//
//  Created by Jon Gabilondo on 05/07/2019.
//  Copyright © 2019 organismo-mobile. All rights reserved.
//

#import "ORGUITreeNode.h"

@implementation ORGUITreeNode

- (instancetype)initWithView:(nonnull NSView*)view {
    self = [super init];
    if (self) {
        self.uiElement = view;
        self.children = [[NSMutableArray alloc] init];
    }
    return self;
}

- (NSString*)title {
    if ([self.uiElement isKindOfClass:[NSWindow class]]) {
        NSWindow *window = (NSWindow*)self.uiElement;
        return window.title;
    }
    return @"Unknown";
}

- (NSString*)descriptor {
    if ([self.uiElement respondsToSelector:@selector(ORG_description)]) {
        return [self.uiElement performSelector:@selector(ORG_description)];
    } else {
        
        return self.className;
    }
}

- (NSRect)rect {
    if ([self.uiElement isKindOfClass:[NSWindow class]]) {
        NSWindow *window = (NSWindow*)self.uiElement;
        return window.frame;
    } else if ([self.uiElement isKindOfClass:[NSView class]]) {
        NSView *view = (NSView*)self.uiElement;
        return view.frame;
    }
    return NSZeroRect;
}

- (BOOL)isHidden {
    if ([self.uiElement isKindOfClass:[NSWindow class]]) {
        NSWindow *window = (NSWindow*)self.uiElement;
        return !window.isVisible;
    } else if ([self.uiElement isKindOfClass:[NSView class]]) {
        NSView *view = (NSView*)self.uiElement;
        return view.isHidden;
    }
    return NO;
}

- (NSString*)className {
    return [[NSString alloc] initWithFormat:@"%@", NSStringFromClass(self.uiElement.class)];
}

- (NSImage*)thumbnailImage {
    NSImage * image;
    NSBundle *orgFramework = [NSBundle bundleWithIdentifier: @"com.organismo-mobile.Organismo"];
    
    if ([self.uiElement isKindOfClass:[NSWindow class]]) {
        image = [orgFramework imageForResource:@"NSWindow_32_Normal"];
    } else  if ([self.uiElement isKindOfClass:[NSPopUpButton class]]) {
        image = [orgFramework imageForResource:@"NSPopUp-Push_32_Normal"];
    } else  if ([self.uiElement isKindOfClass:[NSButton class]]) {
        NSButton *button = (NSButton*)self.uiElement;
        NSString *buttonType = [button performSelector:@selector(ns_widgetType)];
        //NSLog(@"widget type %@", buttonType);
        if ([buttonType isEqualToString:@"RadioButton"]) {
            image = [orgFramework imageForResource:@"NSButton-Radio_32_Normal"];
        } else if ([buttonType isEqualToString:@"HelpButton"]) {
            image = [orgFramework imageForResource:@"NSButton-Help_32_Normal"];
        } else if ([buttonType isEqualToString:@"RoundRectButton"]) {
            image = [orgFramework imageForResource:@"NSButton-RoundRect_32_Normal"];
        } else if ([buttonType isEqualToString:@"CheckBox"]) {
            image = [orgFramework imageForResource:@"NSButton-Checkbox_32_Normal"];
        } else if ([buttonType isEqualToString:@"Disclosure"]) {
            image = [orgFramework imageForResource:@"NSButton-Disclosure_32_Normal"];
        } else if ([buttonType isEqualToString:@"DisclosureTriangle"]) {
            image = [orgFramework imageForResource:@"NSButton-DisclosureTriangle_32_Normal"];
        } else if ([buttonType isEqualToString:@"RoundRectButton"]) {
            image = [orgFramework imageForResource:@"NSButton-RoundRect_32_Normal"];
        } else if ([buttonType isEqualToString:@"RoundTexturedButton"]) {
            image = [orgFramework imageForResource:@"NSButton-TexturedRounded_32_Normal"];
        } else {
            image = [orgFramework imageForResource:@"NSButton-Push_32_Normal"];
        }
    } else  if ([self.uiElement isKindOfClass:[NSTextField class]]) {
        image = [orgFramework imageForResource:@"NSTextField_32_Normal"];
    } else  if ([self.uiElement isKindOfClass:[NSSecureTextField class]]) {
        image = [orgFramework imageForResource:@"NSSecureTextField_32_Normal"];
    } else  if ([self.uiElement isKindOfClass:[NSSwitch class]]) {
        image = [orgFramework imageForResource:@"NSSwitch_32_Normal"];
    } else  if ([self.uiElement isKindOfClass:[NSStepper class]]) {
        image = [orgFramework imageForResource:@"NSStepper_32_Normal"];
    } else  if ([self.uiElement isKindOfClass:[NSDatePicker class]]) {
        image = [orgFramework imageForResource:@"NSDatePicker_32_Normal"];
    } else  if ([self.uiElement isKindOfClass:[NSSegmentedControl class]]) {
        image = [orgFramework imageForResource:@"NSSegmentedControl_32_Normal"];
    } else  if ([self.uiElement isKindOfClass:[NSColorWell class]]) {
        image = [orgFramework imageForResource:@"NSColorWell_32_Normal"];
    } else  if ([self.uiElement isKindOfClass:[NSPanel class]]) {
        image = [orgFramework imageForResource:@"NSPanel_32_Normal"];
    } else  if ([self.uiElement isKindOfClass:[NSPathControl class]]) {
        image = [orgFramework imageForResource:@"NSPathControl_32_Normal"];
    } else  if ([self.uiElement isKindOfClass:[NSLevelIndicator class]]) {
        image = [orgFramework imageForResource:@"NSLevelIndicator_32_Normal"];
    } else  if ([self.uiElement isKindOfClass:[NSSplitViewController class]]) {
        image = [orgFramework imageForResource:@"NSSplitViewControllerHorizontal_32_Normal"];
    } else  if ([self.uiElement isKindOfClass:[NSScrollView class]]) {
        image = [orgFramework imageForResource:@"NSScrollView_16_Normal"];
    } else  if ([self.uiElement isKindOfClass:[NSProgressIndicator class]]) {
        NSProgressIndicator *progress = (NSProgressIndicator*)self.uiElement;
        switch (progress.style) {
            case NSProgressIndicatorStyleBar: {
                if (progress.indeterminate) {
                    image = [orgFramework imageForResource:@"NSProgressIndicator-Bar-Indeterminate_32_Normal"];
                } else {
                    image = [orgFramework imageForResource:@"NSProgressIndicator-Bar-Determinate_32_Normal"];
                }
            } break;
            case NSProgressIndicatorStyleSpinning: {
                if (progress.indeterminate) {
                    image = [orgFramework imageForResource:@"NSProgressIndicator-Circular-Indeterminate_32_Normal"];
                } else {
                    image = [orgFramework imageForResource:@"NSProgressIndicator-Circular-Determinate_32_Normal"];
                }
            } break;
        }
    } else  if ([self.uiElement isKindOfClass:[NSSlider class]]) {
        NSSlider *slider = (NSSlider*)self.uiElement;
        switch (slider.sliderType) {
            case NSSliderTypeLinear: {
                if (slider.vertical) {
                    if (slider.numberOfTickMarks) {
                        image = [orgFramework imageForResource:@"NSSlider-Vertical-Ticks_32_Normal"];
                    } else {
                        image = [orgFramework imageForResource:@"NSSlider-Vertical_32_Normal"];
                    }
                } else {
                    if (slider.numberOfTickMarks) {
                        image = [orgFramework imageForResource:@"NSSlider-Horizontal-Ticks_32_Normal"];
                    } else {
                        image = [orgFramework imageForResource:@"NSSlider-Horizontal_32_Normal"];
                    }
                }
            } break;
            case NSSliderTypeCircular: {
                image = [orgFramework imageForResource:@"NSSlider-Circular_32_Normal"];
            } break;
        }
    } else {
        NSLog(@"Non handled class: %@", NSStringFromClass(self.uiElement.class));
    }
    return image;
}


@end
