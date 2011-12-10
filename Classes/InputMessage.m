//
//  InputMessage.m
//  TaptraceCopy
//
//  Created by Louis on 2011/3/10.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "InputMessage.h"


@implementation InputMessage


#pragma mark -
#pragma mark Button

-(IBAction) BackPressed:(id)sender
{
	NSLog(@"Message: back button pressed");
	[self dismissModalViewControllerAnimated:YES];
}

-(IBAction) DonePressed:(id)sender
{
	NSLog(@"Message: Done button pressed");
	NSString *path = [self filePath:@"message.txt"];
	NSLog(@"DonePressed path = %@", path);
	
	NSData* datacontent;
	datacontent = [msg.text dataUsingEncoding: NSUTF8StringEncoding];
	[datacontent writeToFile:path atomically:YES];
	// You mustn't do [datacontent release] because we don't alloc the NSData object.
	
	//NSArray *array = [[NSArray alloc] initWithObjects:@"test", nil];
	//[array writeToFile:path atomically:YES];	
	//[array release];
	
	[self dismissModalViewControllerAnimated:YES];	
}


#pragma mark -
#pragma mark File and Reae/Write File

- (NSString *)filePath:(NSString*)name
{
	// First way to get file path
	NSString *homePath = NSHomeDirectory();
	
	NSString *docPath = [homePath stringByAppendingPathComponent:@"Documents"];
	
	NSString *filePath = [docPath stringByAppendingPathComponent:name];
	
	return filePath;
	
	// Second way to get file path
	//NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	//NSString *documentsDirectory = [paths objectAtIndex:0];
	//return [documentsDirectory stringByAppendingPathComponent:name];
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

	// Override point for customization after app launch  
	NSString *path = [self filePath:@"message.txt"];
	NSLog(@"path %@", path);
	
	if ([[NSFileManager defaultManager] fileExistsAtPath:path])
	{
		NSError *error;
		NSLog(@"file exist");
		NSString *content = [[NSString alloc] initWithContentsOfFile:path
															encoding:NSUTF8StringEncoding 
															   error:&error];
		msg.text = content;	
		[content release];
		
		/*
		NSArray *array = [[NSArray alloc] initWithContentsOfFile:path];
		for(NSString	*name in array)
		{
			NSLog(@"%@", name);
		}
		[array release];
		 */
	}
	else
	{
		NSLog(@"create file");
		NSArray *array = [[NSArray alloc] initWithObjects:@"keyin message please", nil];
		[array writeToFile:path atomically:YES];
		// we also can use dictionary writeToFile
		msg.text = [array objectAtIndex:0];	
		[array release];
	}
	
	
	/*
	//============ Read txt file from resource ===============
	//1.get the full path and filename
	NSString *path = 	[[NSBundle mainBundle] pathForResource:@"message" ofType:@"txt" ];
	NSLog(@"path %@", path);
	//NSString *poem = [[NSString alloc] initWithContentsOfFile:path	];
	NSError *error;
	
	//2.get the content of file.
	NSString *content = [[NSString alloc] initWithContentsOfFile:path
													 encoding:NSUTF8StringEncoding 
														error:&error];
	
	//in UiTextView, @property(nonatomic,copy) NSString *text;
	msg.text = content;	
	// content retain
	// msg.text release
	// msg.text point to content

	[content release];
	 */
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
	[msg release];	//LN: I still don't know why I need to release this object
					//LN: It might be the same as what I did for MapView
    [super dealloc];
	
}


@end
