//
//  SecondMainScreen.m
//  TaptraceCopy
//
//  Created by Louis on 2011/3/5.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SecondMainScreen.h"
#import "GoogleMapViewController.h"
#import "Wrapper.h"


@implementation SecondMainScreen

#pragma mark -
#pragma mark Button Action Start
-(IBAction) buttonBackPressed:(id)sender
{
	NSLog(@"Back Button Pressed!");
	NSLog(@"buttonBack SecondController %d", [self retainCount]);
	[self dismissModalViewControllerAnimated:YES];
	NSLog(@"dismiss buttonBack SecondController %d", [self retainCount]);
}

-(IBAction) buttonEnterGmapPressed:(id)sender
{
	NSLog(@"Enter Gmap Button Pressed!");
	GoogleMapViewController *GoogleMap = [[GoogleMapViewController alloc] init];
	[self presentModalViewController:GoogleMap animated:YES];
	[GoogleMap release];
	//[self.view removeFromSuperview];
	//[self release];
}


-(IBAction) buttonTurnOnGPSPressed:(id)sender
{
	NSLog(@"Enter buttonTurnOnGPSPressed Button Pressed!");
	
	UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Enter PIN"
														message:@"empty message?"
													   delegate:self
											  cancelButtonTitle:@"Cancel"		// buttonIndex 0
											  otherButtonTitles:@"OK", nil];	// buttonIndex 1
	[alertView show];
	[alertView release];	
}

#pragma mark -
#pragma mark UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView 
clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if([alertView.title isEqualToString:@"Enter PIN"])
	{
		UIAlertView *newAlertView;
		switch (buttonIndex) {
			case 1:
				newAlertView = [[UIAlertView alloc] initWithTitle:@"In Correct PIN"
														  message:@"Would you like to try again"
														 delegate:self
												cancelButtonTitle:@"Cancel"
												otherButtonTitles:@"OK", nil];
				[newAlertView show];
				[newAlertView release];
				break;
			case 0:
				/*
				newAlertView = [[UIAlertView alloc] initWithTitle:@"Bad Choice"
														  message:nil
														 delegate:nil
												cancelButtonTitle:@"Ok"
												otherButtonTitles:nil];
				[newAlertView show];
				[newAlertView release];
				break;
				 */
			default:
				break;
		}// switch
	}// if
	else if([alertView.title isEqualToString:@"In Correct PIN"])
	{
		UIAlertView *newAlertView;
		switch (buttonIndex) {
			case 1:
				newAlertView = [[UIAlertView alloc]			  initWithTitle:@"Enter PIN"
																	message:@"empty message?"
																   delegate:self
														  cancelButtonTitle:@"Cancel"		// buttonIndex 0
														  otherButtonTitles:@"OK", nil];	// buttonIndex 1
				[newAlertView show];
				[newAlertView release];	
				break;
			case 0:
				/*
				 newAlertView = [[UIAlertView alloc] initWithTitle:@"Bad Choice"
				 message:nil
				 delegate:nil
				 cancelButtonTitle:@"Ok"
				 otherButtonTitles:nil];
				 [newAlertView show];
				 [newAlertView release];
				 break;
				 */
			default:
				break;
		}// switch
	}// if
	
}



#pragma mark -
#pragma mark CLLocationManagerDelegate

-(void)locationManager:(CLLocationManager *) manager	
		didEnterRegion:(CLRegion *)region
{
	NSLog(@"didEnterRegion");
}

-(void)locationManager:(CLLocationManager *) manager	
		 didExitRegion:(CLRegion *)region
{
	NSLog(@"didExitRegion");
}

-(void)locationManager:(CLLocationManager *) manager	
	  didFailWithError:(NSError *) error
{
	NSLog(@"didFailWithError");
}

-(void)locationManager:(CLLocationManager *) manager	
	  didUpdateHeading:(CLHeading *)newHeading
{
	NSLog(@"didUpdateHeading");
}

-(void)locationManager:(CLLocationManager *) manager	
   didUpdateToLocation:(CLLocation *)newLocation
		  fromLocation:(CLLocation *)oldLocation
{
	NSLog(@"didUpdateToLocation");
	NSLog(@"latitude = %f, longtitude = %f", newLocation.coordinate.latitude, newLocation.coordinate.longitude );

	[self launch_latitude:(CLLocation *)newLocation];
	//newloc = newLocation;
}

-(void)locationManager:(CLLocationManager *) manager	
monitoringDidFailForRegion:(CLRegion *)region
			 withError:(NSError *)error
{
	NSLog(@"monitoringDidFailForRegion");
}


#pragma mark -
#pragma mark WrapperDelegate methods
// LN I dont need to implement WrapperDelegate in WrapperDelegate.m
- (void)wrapper:(Wrapper *)wrapper didRetrieveData:(NSData *)data
{
	//LN I can use every Wrapper method in Controller class
    NSString *text = [engine responseAsText];
    if (text != nil)
    {
        output.text = text;
    }
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (void)wrapperHasBadCredentials:(Wrapper *)wrapper
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Bad credentials!" 
                                                    message:@"Bad credentials!"  
                                                   delegate:self 
                                          cancelButtonTitle:@"OK" 
                                          otherButtonTitles:nil];
    [alert show];
    [alert release];
}

- (void)wrapper:(Wrapper *)wrapper didCreateResourceAtURL:(NSString *)url
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Resource created!" 
                                                    message:[NSString stringWithFormat:@"Resource created at %@!", url]  
                                                   delegate:self 
                                          cancelButtonTitle:@"OK" 
                                          otherButtonTitles:nil];
    [alert show];
    [alert release];
}

- (void)wrapper:(Wrapper *)wrapper didFailWithError:(NSError *)error
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error!" 
                                                    message:[NSString stringWithFormat:@"Error code: %d!", [error code]]  
                                                   delegate:self 
                                          cancelButtonTitle:@"OK" 
                                          otherButtonTitles:nil];
    [alert show];
    [alert release];
}

- (void)wrapper:(Wrapper *)wrapper didReceiveStatusCode:(int)statusCode
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Status code not OK!" 
                                                    message:[NSString stringWithFormat:@"Status code not OK: %d!", statusCode]
                                                   delegate:self 
                                          cancelButtonTitle:@"OK" 
                                          otherButtonTitles:nil];
    [alert show];
    [alert release];
}



#pragma mark -
#pragma mark method implement

#define MODIFY3 1
#define INPUT_NAME 2
#define PHPFILE INPUT_NAME

-(NSString *)getfilepath
{
	NSString *docPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
	NSString *path = [docPath stringByAppendingPathComponent:@"TapSetting.plist"];
	return path;
}


-(NSString *)returnToken:(NSString *)SeparateString
{
	NSArray *listItems = [SeparateString componentsSeparatedByString:@"<"];
	NSString *strProcess1 =  [listItems objectAtIndex:1]; // result will be: {@"<", @"447201347>"}
	NSArray *listItems2 = [strProcess1 componentsSeparatedByString:@">"];// result will be: {@"44720134",">"}
	return [listItems2 objectAtIndex:0];
}

-(void)launch_latitude:(CLLocation *)Location
{
#if PHPFILE==INPUT_NAME
	// get the path of TapSetting.plist
	NSString * path = [self getfilepath];
	
    NSURL *url = [NSURL URLWithString:@"http://innorz.servehttp.com/input_name.php"];
	NSString *latitude = [NSString stringWithFormat:@"%f", Location.coordinate.latitude];
	NSString *longitude = [NSString stringWithFormat:@"%f", Location.coordinate.longitude];

	// get value from TapSetting.plist
	NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];
	NSString *username = [dict objectForKey:@"username"];
	NSString *tokenTmp = [dict objectForKey:@"devicetoken"];
	
	NSString *token =  [self returnToken:tokenTmp];
	
	
	NSLog(@" processed token = %@", token);

	//NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	//NSString *documentsDirectory = [paths objectAtIndex:0];
	
    //if ([parameter.text length] > 0)
    //{
	NSArray *keys = [NSArray arrayWithObjects:@"name", @"deviceToken", @"input_latitude1", @"input_longtitude1",  nil];
	NSArray *values = [NSArray arrayWithObjects:username, token, latitude, longitude, nil];
	
	
	NSDictionary *parameters = [NSDictionary dictionaryWithObjects:values forKeys:keys];
    //}
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    output.text = @"";
    
    if (engine == nil)
    {
		NSLog(@"engine alloc");
        engine = [[Wrapper alloc] init];
        engine.delegate = self;
    }
	NSLog(@"url=%@", url);
    [engine sendRequestTo:url usingVerb:@"POST" withParameters:parameters];  	
	
	
#elif PHPFILE==MODIFY3
    NSURL *url = [NSURL URLWithString:@"http://innorz.servehttp.com/modify3.php"];
	NSString *latitude = [NSString stringWithFormat:@"%f", Location.coordinate.latitude];
	NSString *longitude = [NSString stringWithFormat:@"%f", Location.coordinate.longitude];

    //if ([parameter.text length] > 0)
    //{
        NSArray *keys = [NSArray arrayWithObjects:@"parameter", @"parameter2", nil];
        NSArray *values = [NSArray arrayWithObjects:latitude, longitude, nil];
        NSDictionary *parameters = [NSDictionary dictionaryWithObjects:values forKeys:keys];
    //}
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    output.text = @"";
    
    if (engine == nil)
    {
		NSLog(@"engine alloc");
        engine = [[Wrapper alloc] init];	// engine is a Wrapper object that provide web function
        engine.delegate = self;
    }
	NSLog(@"url=%@", url);
    [engine sendRequestTo:url usingVerb:@"POST" withParameters:parameters];  
#endif
}


-(id)initwithLocation:(CLLocationManager*)Location
{
	locManager = (CLLocationManager*)Location;
	return [self init];
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


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
		locManager = [[CLLocationManager alloc] init];
		[locManager startUpdatingLocation];	
		locManager.delegate = self;	

	NSLog(@"Second ViewDidLoad");
}



- (void)viewDidUnload {
	NSLog(@"viewDidUnload SecondController %d", [self retainCount]);
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[engine release];
	[locManager release];
    [super dealloc];
}
@end





