//
//  LogInViewController.m
//  TestingApp
//
//  Created by Nishant kumar on 11/05/14.
//  Copyright (c) 2014 Angelhack. All rights reserved.
//

#import "LogInViewController.h"
#import "AppDetailViewController.h"
#import "AppDelegate.h"

@interface LogInViewController ()
{
    AppDelegate *appDel;
}
@end

@implementation LogInViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    appDel=(AppDelegate *)[[UIApplication sharedApplication]delegate];
}



#pragma UIButton Action

-(IBAction)logInAction:(id)sender
{
    if (emailIdTF.text.length>0||passwordTF.text.length>0) {
        appDel.uid=emailIdTF.text;
        AppDetailViewController *detail=[[AppDetailViewController alloc]initWithNibName:@"AppDetailViewController" bundle:nil];
        //[self.navigationController pushViewController:detail animated:YES];
        [self.navigationController popViewControllerAnimated:YES];
       // [self presentViewController:detail animated:YES completion:nil];
    }else{
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Error!!" message:@"Mandatory Fields are blank." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
    
}

#pragma TextField Delegate Method

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField==emailIdTF) {
        [self validateMailID];
    }
    //[scroll setContentOffset:CGPointMake(0, 0) animated:YES];
}
-(void)validateMailID
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    if (![emailTest evaluateWithObject:emailIdTF.text]) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Error" message:@"Please Enter Valid Email Address" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        emailIdTF.text=@"";
        //[scroll setContentOffset:CGPointMake(0, 0) animated:YES];
        return;
        
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
