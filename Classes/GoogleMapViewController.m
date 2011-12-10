//
//  GoogleMapViewController.m
//  TaptraceCopy
//
//  Created by Louis on 2011/3/10.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

int first=0;

#import "GoogleMapViewController.h"


@implementation GoogleMapViewController

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
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/


/*========= Louis ===========
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
    [super dealloc];
}


@end

========= Louis ===========*/


//===============================
//
//  GooglemapDemoViewController.m
//  GooglemapDemo
//
//  Created by Eric Lin on 2010/7/22.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//





/*
 // The designated initializer. Override to perform setup that is required before the view is loaded.
 - (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
 if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
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
#pragma mark Target-Action

//=======================================
//LN: To put device's location centrally
- (void) centerPosition {
	NSLog(@"part 1 centerPosition mapView retaincount %d",[mapView retainCount]);
	// 若現在的地點在地圖上已經看不到，則將地圖的中心點設定為目前位置 
	if( mapView.userLocation.coordinate.latitude>0 && mapView.userLocation.coordinate.longitude>0 
	   && ![mapView isUserLocationVisible] ) 
	{
		//NSLog(@"part 2 centerPosition mapView retaincount %d",[mapView retainCount]);		
		[mapView setCenterCoordinate:mapView.userLocation.coordinate animated:YES];
		//NSLog(@"part 3 centerPosition mapView retaincount %d",[mapView retainCount]);
	}
	NSLog(@"centerPosition mapView retaincount %d",[mapView retainCount]);
	//NSLog(@"centerPosition locManager retaincount %d",[locManager retainCount]);
	NSLog(@"centerPosition busy retaincount %d",[busy retainCount]);
}

- (IBAction)centerToCurrentLocation:(id)sender {
	[self centerPosition];
	[mapView setCenterCoordinate:mapView.userLocation.coordinate animated:YES];
	//[self updateRegionForLocation:newloc keepSpan:YES];
}


- (IBAction)gobacktoSecondMenu:(id)sender
{
	//NSLog(@"locManager retaincount %d",[locManager retainCount]);
	//NSLog(@"mapView retaincount %d",[mapView retainCount]);
	//NSLog(@"busy retaincount %d",[busy retainCount]);
	
	NSLog(@"Go back to Second Menu Button Pressed!");
	[self dismissModalViewControllerAnimated:YES];
}




#pragma mark -
#pragma mark MKMapViewDelegate
//==========================
// MKMapViewDelegate events
//==========================

// 開始載入地圖時顯示等待的動畫
- (void)mapViewWillStartLoadingMap:(MKMapView *) theMapView {
	if( busy==nil ){
		busy = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
		busy.frame = CGRectMake(120, 180, 80, 80);
		//LN: [view addSubview:busy]; it will fail because we don't have view member in our class
		// view member is inherited from parent class
		[self.view addSubview:busy];
		[busy release];
	}
	busy.hidesWhenStopped = YES;
	[busy startAnimating];
}

// 完全載入地圖後停止等待動畫
- (void)mapViewDidFinishLoadingMap:(MKMapView *) theMapView {
	[busy stopAnimating];
}

// 使用者位置更新後，讓現在位置置中
- (void)mapView:(MKMapView *)mapView 
		didUpdateUserLocation:(MKUserLocation *)userLocation 
{
	if( !setup ){
		setup = YES;
		[self updateRegionForLocation:userLocation.location keepSpan:NO];
	} else {
		[self updateRegionForLocation:userLocation.location keepSpan:YES];
	}
	
	// 移動位置時，讓現在位置置中
	[self centerPosition];
}

//LN: location update once, map update once
- (void) updateRegionForLocation:(CLLocation *) newLocation 
		 keepSpan:(BOOL) keepSpan
{
	MKCoordinateRegion theRegion;
	theRegion.center = newLocation.coordinate;
	
	if( !keepSpan ){
		MKCoordinateSpan theSpan;
		theSpan.latitudeDelta = 0.1;	// give 0.01, it will crash
		theSpan.longitudeDelta = 0.1;	// the same as above
		theRegion.span = theSpan;
		NSLog(@"keepSpan=0");
	}else {
		theRegion.span = mapView.region.span;
		NSLog(@"keepSpan=1");

	}
	[mapView setRegion:theRegion animated:YES];
}

#pragma mark -
#pragma mark System Routine
////////////////////////////

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	//if(first==0){

		mapView.delegate = self;
		first=1;
		NSLog(@"first enter");
	//}
	
	//locManager = [[CLLocationManager alloc] init];
	//[locManager startUpdatingLocation];	
	//mapView.delegate = self;
	//locManager.delegate = self;
	//first=1;
	//NSLog(@"first enter");
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
	//LN will cause the crash, while go back to second and pass 10 seconds later
	//NSLog(@"gmap view DidUnload");
}

//LN:view's rC==0, dealloc will run
- (void)dealloc {
	//[busy release];
	[mapView release];
	[super dealloc];
}

@end
