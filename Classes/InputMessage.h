//
//  InputMessage.h
//  TaptraceCopy
//
//  Created by Louis on 2011/3/10.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface InputMessage : UIViewController {
	IBOutlet UIBarButtonItem *BackBtn;
	IBOutlet UIBarButtonItem *DoneBtn;
	IBOutlet UITextView *msg;
}
-(IBAction) BackPressed:(id)sender;
-(IBAction) DonePressed:(id)sender;
- (NSString *)filePath:(NSString*)name;
@end
