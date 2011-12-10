//
//  GoogleMapViewController.h
//  TaptraceCopy
//
//  Created by Louis on 2011/3/10.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//


/* Louis
#import <UIKit/UIKit.h>


@interface GoogleMapViewController : UIViewController {

}

@end
*/


//============================
//
//  GooglemapDemoViewController.h
//  GooglemapDemo
//
//  Created by Eric Lin on 2010/7/22.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//


#import <MapKit/MapKit.h>

	//CLLocation *newloc;
@interface GoogleMapViewController : UIViewController <MKMapViewDelegate>{
		
	IBOutlet MKMapView *mapView;	//LN: build a UI component by IB, we don't have to alloc it.
	IBOutlet UIBarButtonItem *centerBtn;
	IBOutlet UIBarButtonItem *backBtn;
	UIActivityIndicatorView *busy;
	BOOL setup;
}
- (IBAction)centerToCurrentLocation:(id)sender;
- (IBAction)gobacktoSecondMenu:(id)sender;
- (void) updateRegionForLocation:(CLLocation *) newLocation keepSpan:(BOOL) keepSpan;
@end


