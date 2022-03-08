//
//  ORGLibrariesViewController.m
//  Organismo-mac
//
//  Created by Jon Gabilondo on 27/02/2020.
//  Copyright © 2020 organismo-mobile. All rights reserved.
//

#import "ORGLibrariesViewController.h"
#import "ORGClassesViewController.h"
#import "ORGViewContainer.h"
#import "NSBundle+ORG.h"
#import "NSStoryboard+ORG.h"
#import <objc/runtime.h>

@interface ORGLibrariesViewController ()
@property (weak) IBOutlet ORGViewContainer *rightSideView;
@property (strong) IBOutlet NSArrayController *librariesArrayController;
@property (strong) IBOutlet NSArrayController *classesArrayController;
@property (weak) IBOutlet NSTableView *librariesTableView;
@property (nonatomic) ORGClassesViewController *classesViewController;
@end

static NSImage *thumbnailDylib;
static NSImage *thumbnailFramework;

@implementation ORGLibrariesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadImageNames];
    
    // Install Classes view
    self.classesViewController = [NSStoryboard ORG_instantiateControllerWithIdentifier:@"ORGClassesViewController"];

    [self.rightSideView addSubviewOfController:self.classesViewController];
    [self addChildViewController:self.classesViewController];
}

- (void)loadImageNames {
    // Based on FLEX https://github.com/Flipboard/FLEX

    unsigned int imageNamesCount = 0;
    const char **imageNames = objc_copyImageNames(&imageNamesCount);
    if (imageNames) {
        NSString *appImageName = [NSBundle mainBundle].executablePath;
        for (unsigned int i = 0; i < imageNamesCount; i++) {
            const char *imageName = imageNames[i];
            NSString *imageNameString = [NSString stringWithUTF8String:imageName];
            // Skip the app's image. We're just showing system libraries and frameworks.
            if (![imageNameString isEqual:appImageName]) {
                [self.librariesArrayController addObject:@{@"name":imageNameString, @"image":[self thumbnailImageFor:imageNameString]}];
            }
        }
        
        // Sort alphabetically
//        self.imageNames = [imageNameStrings sortedArrayWithOptions:0 usingComparator:^NSComparisonResult(NSString *name1, NSString *name2) {
//            NSString *shortName1 = [self shortNameForImageName:name1];
//            NSString *shortName2 = [self shortNameForImageName:name2];
//            return [shortName1 caseInsensitiveCompare:shortName2];
//        }];
        
        free(imageNames);
    }
}

- (void)loadClassesForImage:(const char *)imageName {
    unsigned int classNamesCount = 0;
    const char **classNames = objc_copyClassNamesForImage(imageName, &classNamesCount);
    if (classNames) {
        for (unsigned int i = 0; i < classNamesCount; i++) {
            const char *className = classNames[i];
            NSString *classNameString = [NSString stringWithUTF8String:className];
            [self.classesArrayController addObject:classNameString];
        }

        free(classNames);
    }
}

- (NSString *)shortNameForImageName:(NSString *)imageName {
    NSArray<NSString *> *components = [imageName componentsSeparatedByString:@"/"];
    if (components.count >= 2) {
        return [NSString stringWithFormat:@"%@/%@", components[components.count - 2], components[components.count - 1]];
    }
    return imageName.lastPathComponent;
}

- (IBAction)librarySelection:(id)sender {
    NSTableView *table = sender;
    NSDictionary<NSString*, NSString*> *selected = [[self.librariesArrayController arrangedObjects] objectAtIndex:[table selectedRow]];
    NSString *name = selected[@"name"];
    
    [self.classesViewController loadImageClassNames:name];
}

- (BOOL)isDylib:(NSString*)libraryName {
    return [libraryName containsString:@".dylib"];
}

- (BOOL)isFramework:(NSString*)libraryName {
    return [libraryName containsString:@".framework"];
}

- (NSImage*)thumbnailImageFor:(NSString*)libraryName {
    NSImage *image;
    NSBundle *orgFramework = [NSBundle ORGFrameworkBundle];

    if ([self isDylib:libraryName]) {
        if (!thumbnailDylib) {
            thumbnailDylib = [orgFramework imageForResource:@"dylib_16x16_Normal"];
        }
        image = thumbnailDylib;
    } else  {
        if (!thumbnailFramework) {
            thumbnailFramework = [orgFramework imageForResource:@"framework_16x16_Normal"];
        }
        image = thumbnailFramework;
    }
    return image;
}

@end
