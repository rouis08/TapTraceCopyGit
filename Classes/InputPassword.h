//
//  InputPassword.h
//  TaptraceCopy
//
//  Created by Louis on 2011/3/10.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TaptraceCopyViewController.h"


@interface InputPassword : UIViewController 
{
	IBOutlet UITextField *password;
	IBOutlet UITextField *username;
	IBOutlet UILabel *token;
	IBOutlet UIButton *PassBack;
	TaptraceCopyViewController *Tap;
}
-(IBAction) doneEditing:(id)sender;
-(IBAction) buttonPassBackPressed:(id)sender;
-(id)initWithObject:(TaptraceCopyViewController *)Tapp;
@property(nonatomic, assign) TaptraceCopyViewController *Tap;
//@property(nonatomic,retain) UITextField *password;
//@property(nonatomic,retain) UITextField *username;
@end