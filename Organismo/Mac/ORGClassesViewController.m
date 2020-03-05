//
//  ORGClassesViewController.m
//  Organismo-mac
//
//  Created by Jon Gabilondo on 05/03/2020.
//  Copyright © 2020 organismo-mobile. All rights reserved.
//

#import "ORGClassesViewController.h"
#import "NSBundle+ORG.h"
#import <objc/runtime.h>

@interface ORGClassesViewController ()
@property (strong) IBOutlet NSTreeController *classesTreeController;

@end

@implementation ORGClassesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadClassNames];
}

- (NSImage*)thumbnailImageForClass {
    NSBundle *orgFramework = [NSBundle ORGFrameworkBundle];
    return [orgFramework imageForResource:@"class_16x16_Normal"];
}

- (void)loadClassNames {
    unsigned int classNamesCount = 0;
    const char **classNames = objc_copyClassNamesForImage([[NSBundle mainBundle].executablePath UTF8String], &classNamesCount);
    if (classNames) {
        for (unsigned int i = 0; i < classNamesCount; i++) {
            const char *className = classNames[i];
            NSString *classNameString = [NSString stringWithUTF8String:className];
            [self.classesTreeController addObject:@{@"name":classNameString, @"image":[self thumbnailImageForClass], @"children":@[]}];
        }
        free(classNames);
    }
}


@end
