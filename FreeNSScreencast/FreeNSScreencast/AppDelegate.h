//
//  AppDelegate.h
//  FreeNSScreencast
//
//  Created by Jesse Stevens Black on 7/26/13.
//  Copyright (c) 2013 Jesse Stevens Black. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ViewController;
@interface AppDelegate : UIResponder <UIApplicationDelegate, NSXMLParserDelegate>
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) NSMutableArray *items;
@property (strong, nonatomic) ViewController *viewController;

@end
