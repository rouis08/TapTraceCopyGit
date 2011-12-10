//
//  TaptraceCopyAppDelegate.m
//  TaptraceCopy
//
//  Created by Louis on 2011/3/5.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TaptraceCopyAppDelegate.h"
#import "TaptraceCopyViewController.h"

@implementation TaptraceCopyAppDelegate

@synthesize window;
@synthesize viewController;

#pragma mark -
#pragma mark PUSH Notification 

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
    // Override point for customization after application launch.
	
    // Add the view controller's view to the window and display.
    [self.window addSubview:viewController.view];
    [self.window makeKeyAndVisible];
	
	//LN: register to APNS
	[[UIApplication sharedApplication] registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeSound];
	
    return YES;
}

//LN: we get the device token from APNS
- (void)application:(UIApplication *)app 
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken 
{   
	NSLog(@"Device token retainCount1 = %d",viewController.token);
	viewController.token = [deviceToken description];
	NSLog(@"Device token retainCount2 = %d",viewController.token);
	NSLog(@"Device token:%@",[deviceToken description]);
	/*
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"token" 
											  message:viewController.token.text 
											  delegate:self 
											  cancelButtonTitle:@"ok" 
										      otherButtonTitles:nil]; 
    [alert show];     
	[alert release];
	 */
}


- (void)application:(UIApplication *)app didFailToRegisterForRemoteNotificationsWithError:(NSError *)err {     
    viewController.token = [err description];
}	


//LN: we receive the message from APNS
- (void)application:(UIApplication *)application 
didReceiveRemoteNotification:(NSDictionary *)userInfo 
{
	viewController.token = [userInfo description];
	NSLog(@"Receive notification:%@",[userInfo description]);

	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"message" 
												message:viewController.token
												delegate:self 
												cancelButtonTitle:@"ok" 
												otherButtonTitles:nil]; 
    [alert show];     
	[alert release];
}

//LN mobile phone can support these kinds of notification
- (UIRemoteNotificationType)enabledRemoteNotificationTypes 
{
	return UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeSound;
}

#pragma mark -
#pragma mark Application lifecycle

- (void)applicationWillResignActive:(UIApplication *)application 
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidEnterBackground:(UIApplication *)application 
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
}


- (void)applicationWillEnterForeground:(UIApplication *)application 
{
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application 
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application 
{
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application 
{
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc {
    [viewController release];
    [window release];
    [super dealloc];
}


@end
