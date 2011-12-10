//
//  TaptraceCopyViewController.h
//  TaptraceCopy
//
//  Created by Louis on 2011/3/5.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface TaptraceCopyViewController : UIViewController {
	
	IBOutlet UIButton *CreateDefaultMsg;
	IBOutlet UIButton *CreatePinNum;
	IBOutlet UIButton *LockTap;	
    NSString *token;
	//CLLocationManager *locManager;
	
}
-(IBAction) buttonMsgPressed:(id)sender;
-(IBAction) buttonPinPressed:(id)sender;
-(IBAction) buttonLockPressed:(id)sender;
@property(nonatomic,assign) NSString *token;		//LN NSString just give the assign type
@end

