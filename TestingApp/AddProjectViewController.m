//
//  AddProjectViewController.m
//  TestingApp
//
//  Created by Nishant kumar on 11/05/14.
//  Copyright (c) 2014 Angelhack. All rights reserved.
//

#import "AddProjectViewController.h"
#import "MainViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "ManipulateImageVC.h"
#import "AppDelegate.h"

@interface AddProjectViewController ()
{
    NSString *nameStr, *categoryStr, *detailStr, *tagsStr, *linkStr;
    UIColor *currentColor;
    AppDelegate *appDel;
     NSString *placeholderText;
    UIToolbar *toolbar;
}
@end

@implementation AddProjectViewController

@synthesize typeName;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)setTypeName:(NSString *)type
{
    typeName=type;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    appDel=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    discriptionTV.layer.borderColor=[[UIColor lightGrayColor]CGColor];
    discriptionTV.layer.borderWidth=1.0f;
    discriptionTV.layer.cornerRadius=6.0;
    iconImgView.layer.borderColor=[[UIColor lightGrayColor]CGColor];
    iconImgView.layer.borderWidth=1.5f;
    iconImgView.layer.cornerRadius=3.0;
    iconImgView.layer.shadowOffset=CGSizeMake(4, 12);
    iconImgView.layer.shadowOpacity=40.0f;
    iconImgView.layer.shadowColor=[[UIColor lightGrayColor]CGColor];
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handelTap)];
    [iconImgView setUserInteractionEnabled:YES];
    [iconImgView addGestureRecognizer:tap];
    
    UISwipeGestureRecognizer *leftSwipe=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handelLeftSwipe:)];
    [leftSwipe setDirection:UISwipeGestureRecognizerDirectionLeft];
    [self.view addGestureRecognizer:leftSwipe];
    
    placeholderText=@"Put Your Review Text here.";
    discriptionTV.text=placeholderText;
    /////toolbar for TextView
    toolbar=[[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    UIBarButtonItem *flexbtn=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem *donebtn=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(hideKeyboard:)];
    NSArray *arr=[NSArray arrayWithObjects:flexbtn,donebtn,nil];
    [toolbar setItems:arr];
}
-(void)handelLeftSwipe:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)handelTap
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate=self;
    picker.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.modalPresentationStyle=UIModalPresentationFormSheet;
    [self presentModalViewController:picker animated:YES];
}
#pragma ImagePicker Delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSLog(@"Removing Temp files.");
    
    
    UIImage *ClipboardImage=[info objectForKey:@"UIImagePickerControllerOriginalImage"];
    // UIImageView *imgview=[[UIImageView alloc]initWithImage:ClipboardImage];
    UIImage *newImg;
    
    UIGraphicsBeginImageContext(CGSizeMake(ClipboardImage.size.width,ClipboardImage.size.height));
    [ClipboardImage drawInRect:CGRectMake(0, 0,ClipboardImage.size.width,ClipboardImage.size.height)];
    newImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    // CGSize size = [newImg size];
    [picker dismissModalViewControllerAnimated:YES];
    
    [self performSelector:@selector(cropView:) withObject:newImg afterDelay:0.3];
}
-(IBAction)cropView:(id)sender
{
    ManipulateImageVC *mImage=[[ManipulateImageVC alloc]initWithNibName:@"ManipulateImageVC" bundle:nil];
    mImage.photo=sender;
    [self.navigationController pushViewController:mImage animated:YES];
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES];
    if ([typeName isEqualToString:@"Ios"]) {
        currentColor=[UIColor colorWithRed:180.0/255.0 green:112.0/255.0 blue:69.0/255.0 alpha:1];
        [headerView setBackgroundColor:currentColor];
    }else{
        [headerView setBackgroundColor:[UIColor colorWithRed:99.0/255.0 green:102.0/255.0 blue:180.0/255.0 alpha:1]];
        currentColor=[UIColor colorWithRed:99.0/255.0 green:102.0/255.0 blue:180.0/255.0 alpha:1];
    }
}

-(void)viewDidAppear:(BOOL)animated
{
    if (appDel.iconImage) {
        iconImgView.image=appDel.iconImage;
    }else{
        iconImgView.image=[UIImage imageNamed:@"Unknown.png"];

    }
        NSLog(@"appDelIcon %@",appDel.iconImage);
    
}

#pragma UIButton Action
-(IBAction)submitButtonAction:(id)sender
{
    if ((nameStr.length>0)&&(detailStr.length>0)) {
        [appDel.IosNameArr addObject:nameStr];
        [appDel.IosDetailArr addObject:detailStr];
        NSString *imgName=[NSString stringWithFormat:@"%@.png",nameStr];
        [appDel.IosImageArr addObject:imgName];
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *savedTempImagePath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png",nameStr]];
        
        NSData *imageData = UIImagePNGRepresentation(iconImgView.image);
        [imageData writeToFile:savedTempImagePath atomically:YES];
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Success" message:@"Project Added Successfuly." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        alert.tag=200;
        [alert show];
        
    }else{
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Error!!" message:@"Please Fill Mandatory Fields." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        nameTF.borderStyle=UITextBorderStyleLine;
        discriptionTV.layer.borderColor=[[UIColor blackColor]CGColor];
    }
    
    
}

#pragma UIAlertView Delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==200) {
        if (buttonIndex==0) {
            [self.navigationController popViewControllerAnimated:YES];
        }
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
    nameStr=nameTF.text;
    tagsStr=tagsTF.text;
    categoryStr=categoryTF.text;
    linkStr=socialLinkTF.text;
}
#pragma UITextView methods
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    textView.text=@"";
    textView.inputAccessoryView=toolbar;
    return YES;
}
-(IBAction)hideKeyboard:(id)sender
{
    if (discriptionTV.text.length==0) {
        discriptionTV.text=placeholderText;
    }else{
        detailStr=discriptionTV.text;
    }
    [discriptionTV resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
