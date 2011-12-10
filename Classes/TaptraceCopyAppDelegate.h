//
//  TaptraceCopyAppDelegate.h
//  TaptraceCopy
//
//  Created by Louis on 2011/3/5.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TaptraceCopyViewController;

@interface TaptraceCopyAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    TaptraceCopyViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet TaptraceCopyViewController *viewController;


@end
