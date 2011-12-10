//
//  SecondMainScreen.h
//  TaptraceCopy
//
//  Created by Louis on 2011/3/5.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "WrapperDelegate.h"

//LN I only need to declare @class, not have to include their h files
@class Wrapper;


//==========================================================

@interface SecondMainScreen : UIViewController <CLLocationManagerDelegate, WrapperDelegate> {
	
	IBOutlet UIButton *Back;
	IBOutlet UIButton *EnterGmap;
	IBOutlet UIButton *TurnOnGPS;
	
	CLLocationManager *locManager;
	
	UITextView *output;		//LN use for output php webpage
	Wrapper *engine;
}
-(IBAction) buttonEnterGmapPressed:(id)sender;
-(IBAction) buttonTurnOnGPSPressed:(id)sender;
-(void)launch_latitude:(CLLocation *)Location;
-(id)initwithLocation:(CLLocationManager*)Location;
-(NSString *)getfilepath;
-(NSString *)returnToken:(NSString *)SeparateString;
@end

