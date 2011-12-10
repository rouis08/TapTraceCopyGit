//
//  InputPassword.m
//  TaptraceCopy
//
//  Created by Louis on 2011/3/10.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "InputPassword.h"

@implementation InputPassword

@synthesize Tap;

//@synthesize password;
//@synthesize username;


#pragma mark -
#pragma mark Button
-(IBAction) doneEditing:(id)sender
{	
	[sender resignFirstResponder];
/*	
	NSString *error=nil;
	NSPropertyListFormat format;
	//LN: plistpath will point to ini_file.plist of resource bundle.
	//LN: mainBundle is a class-method, we can direct call it.
	
	
	NSString *plistpath=[[NSBundle mainBundle] pathForResource:@"TapConfig" ofType:@"plist"]; 
	// We use NSString to behave a path name which is got from NSBundle.
	// We will use this string frequently.
	
	//write to object
	//	NSFileManager *filemanager=[NSFileManager defaultManager];
	//LN: plistdict will point to plistpath and to retrive data of bundle.
	NSMutableDictionary *plistdict=[[NSMutableDictionary alloc] initWithContentsOfFile:plistpath];
	[plistdict setValue:txtfield.text forKey:@"password"];
	//	[plistdict setValue:@"YES" forKey:@"lock"];
	[plistdict writeToFile:plistpath  atomically:YES];
	
	//LN: we write to mutable dictionary, read from dictionary
	
	//show data
	NSData *plist=[[NSFileManager defaultManager]contentsAtPath:plistpath];
	NSDictionary *tempdata=(NSDictionary *)[NSPropertyListSerialization	propertyListFromData:plist 
																			mutabilityOption:NSPropertyListMutableContainersAndLeaves 
																			format:&format 
																			errorDescription:&error];
	
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Taptrace" 
											  message:[tempdata objectForKey:@"password"] 
											  delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil]; 
    [alert show];     
	[alert release];
*/
}
-(id)initWithObject:(TaptraceCopyViewController *)Tapp
{
	Tap = Tapp;
	return [self init];
}

-(IBAction) buttonPassBackPressed:(id)sender
{
	NSLog(@"Password Page: Back Button Pressed!");
	
	//1.get the full path and filename
	NSString *docPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
	NSString *path = [docPath stringByAppendingPathComponent:@"TapSetting.plist"];
	
	NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:username.text, @"username", @"", @"password",token.text, @"devicetoken",nil];
	[dict writeToFile:path atomically:YES];	
	
	[self dismissModalViewControllerAnimated:YES];

}


#pragma mark -
#pragma mark System Routine

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];

	//1.get the full path and filename
	NSString *docPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
	NSString *path = [docPath stringByAppendingPathComponent:@"TapSetting.plist"];

	NSLog(@"path %@", path);
	//NSString *poem = [[NSString alloc] initWithContentsOfFile:path	];
	
	if ([[NSFileManager defaultManager] fileExistsAtPath:path])
	{
		NSLog(@"file exist");
		//LN: read file to dict, we have date information in filename
		NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];
		NSLog(@"username retain = %d", [username retainCount]);
		NSLog(@"token = retain %d", [token retainCount]);
		username.text = [dict objectForKey:@"username"];
		token.text = [dict objectForKey:@"devicetoken"];
		// crash [dict release];
		
		// crash [username.text release];
		// crash [token.text release];
		
		//LN: I don't release username because I need to release it in dealloc
		// I think above won't retain the username or token
		//[username release];
		//[token release];
		NSLog(@"username = %@", username.text);
		NSLog(@"token = %@", token.text);
		NSLog(@"username retain = %d", [username retainCount]);
		NSLog(@"token = retain %d", [token retainCount]);
	}
	else
	{
		NSLog(@"create file");	
		NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:@"rouislee", @"username", @"", @"password", @"notoken", @"devicetoken",nil];
		[dict writeToFile:path atomically:YES];		
		username.text = [dict objectForKey:@"username"];
		token.text = Tap.token;
		// crash [dict release];
		// crash [username.text release];
		// crash [token.text release];
		//[username release];
		//[token release];
	}

}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[username release];
	[password release];
	[token release];
    [super dealloc];
}


@end
