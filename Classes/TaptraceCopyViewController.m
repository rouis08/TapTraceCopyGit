//
//  TaptraceCopyViewController.m
//  TaptraceCopy
//
//  Created by Louis on 2011/3/5.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TaptraceCopyViewController.h"
#import "SecondMainScreen.h"
#import "InputPassword.h"
#import "InputMessage.h"

@implementation TaptraceCopyViewController

@synthesize token;

#pragma mark -
#pragma mark Button Pressed
-(IBAction) buttonMsgPressed:(id)sender
{
	
	NSLog(@"Message Button Pressed! rc=%d", [CreateDefaultMsg retainCount]);
	InputMessage *MessageView = [InputMessage alloc];

	[self presentModalViewController:MessageView animated:YES];
	[MessageView release];
	
	NSLog(@"Enter Animation: SecondController %d", [MessageView retainCount]);	

}

-(IBAction) buttonPinPressed:(id)sender
{
	
	NSLog(@"PIN Button Pressed!");
	
	InputPassword *InputPasswordViewController = [[InputPassword alloc] initWithObject:self];
	
	NSLog(@"InputPassword retaincount %d",[InputPasswordViewController retainCount]);
	NSLog(@"self retaincount %d",[self retainCount]);
	
	// This line make self+4, Input+3
	[self presentModalViewController:InputPasswordViewController animated:YES];
	[InputPasswordViewController release];
	
	NSLog(@"InputPassword retaincount %d",[InputPasswordViewController retainCount]);
	NSLog(@"self retaincount %d",[self retainCount]);
	
}

-(IBAction) buttonLockPressed:(id)sender
{
	NSLog(@"Lock Button Pressed!");	
	SecondMainScreen *SecondController = [[SecondMainScreen alloc] init];
	NSLog(@"Enter SecondController %d", [SecondController retainCount]);	
	[self presentModalViewController:SecondController animated:YES];
	[SecondController release];
	NSLog(@"Enter Animation: SecondController %d", [SecondController retainCount]);	
}
/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

#pragma mark -
#pragma mark System Routine

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	//locManager = [[CLLocationManager alloc] init];
	NSLog(@"Taptrace viewDidLoad");
}



/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

@end
