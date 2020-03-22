//
//  ORGClassesViewController.h
//  Organismo-mac
//
//  Created by Jon Gabilondo on 05/03/2020.
//  Copyright © 2020 organismo-mobile. All rights reserved.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface ORGClassesViewController : NSViewController

@property (nonatomic) BOOL loadMainBundleClassNamesWhenReady;

- (void)loadImageClassNames:(NSString*)imageName;

@end

NS_ASSUME_NONNULL_END
