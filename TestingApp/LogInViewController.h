//
//  LogInViewController.h
//  TestingApp
//
//  Created by Nishant kumar on 11/05/14.
//  Copyright (c) 2014 Angelhack. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LogInViewController : UIViewController
{
    IBOutlet UITextField *emailIdTF, *passwordTF;
    IBOutlet UIButton *logInBtn;
}

-(IBAction)logInAction:(id)sender;
@end
