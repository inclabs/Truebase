//
//  ManipulateImageVC.m
//  MakeNewHeadlineApp
//
//  Created by Apple on 06/12/12.
//  Copyright (c) 2012 Apple. All rights reserved.
//
#define SHOW_PREVIEW NO

#import "ManipulateImageVC.h"
#import "AddProjectViewController.h"
#import "AppDelegate.h"
#import <QuartzCore/QuartzCore.h>

#ifndef CGWidth
#define CGWidth(rect)                   rect.size.width
#endif

#ifndef CGHeight
#define CGHeight(rect)                  rect.size.height
#endif

#ifndef CGOriginX
#define CGOriginX(rect)                 rect.origin.x
#endif

#ifndef CGOriginY
#define CGOriginY(rect)                 rect.origin.y
#endif

//#define IMAGE_CROPPER_OUTSIDE_STILL_TOUCHABLE 40.0f
//#define IMAGE_CROPPER_INSIDE_STILL_EDGE 20.0f


@interface ManipulateImageVC ()
{
    AddProjectViewController *obj;
    AppDelegate *appDel;
}
@end

@implementation ManipulateImageVC
@synthesize photo, croppedPhoto;

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
    
    UIBarButtonItem* item = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(DoneAction:)];
    item.title=@"Done";
    //[self.view2 addSubview:cameraImage];
    self.navigationItem.rightBarButtonItem = item;
    
    obj=[[AddProjectViewController alloc] initWithNibName:@"AddProjectViewController" bundle:nil];
    appDel=(AppDelegate *)[[UIApplication sharedApplication]delegate];
//    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(cancelView)];
//    self.navigationItem.rightBarButtonItem = doneBtn;
//    self.navigationController.navigationBar.tintColor=[UIColor blackColor];

    
    
    photoCropper =
    [[SSPhotoCropperViewController alloc] initWithPhoto:photo
                                               delegate:self
                                                 uiMode:SSPCUIModePresentedAsModalViewController
                                        showsInfoButton:YES];
    [photoCropper setMinZoomScale:.1f];
    [photoCropper setMaxZoomScale:2.50f];
    photoCropper.view.frame = CGRectMake(10, 40, 300, 500);
    [self.view addSubview:photoCropper.view];
    
    NSUserDefaults *userDefault=[NSUserDefaults standardUserDefaults];
    NSString *strHeight=[userDefault objectForKey:@"framHeight"];
    NSString *strWidth=[userDefault objectForKey:@"framWidth"];
    CGFloat w = photoCropper.photo.size.height;
    CGFloat h = photoCropper.photo.size.width;
    NSLog(@"Width:%f, height:%f", w, h);
    [photoCropper setCropSize:CGSizeMake(w,h)];
    croppedPhoto = nil;
    
}

-(void)viewWillAppear:(BOOL)animated
{
   
    [self.navigationController setNavigationBarHidden:NO];
}
-(void)viewDidDisappear:(BOOL)animated
{
   // [self.navigationController setNavigationBarHidden:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma -
#pragma SSPhotoCropperDelegate Methods

- (void) photoCropper:(SSPhotoCropperViewController *)photoCropper
         didCropPhoto:(UIImage *)aPhoto
{
    NSUserDefaults *userDefault=[NSUserDefaults standardUserDefaults];
    NSString *strHeight=[userDefault objectForKey:@"framHeight"];
    NSString *strWidth=[userDefault objectForKey:@"framWidth"];
    CGFloat w = photoCropper.photo.size.height;
    CGFloat h = photoCropper.photo.size.width;
    UIGraphicsBeginImageContext(CGSizeMake(w, h));
    CGRect imageRect = CGRectMake(0.0, 0.0, w, h);
    [aPhoto drawInRect:imageRect];
    self.croppedPhoto = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    CGSize sz = self.croppedPhoto.size;
    NSLog(@"Width:%f, height:%f", sz.width, sz.height);
}

- (void) photoCropperDidCancel:(SSPhotoCropperViewController *)photoCropper
{
   self.croppedPhoto = nil;
}





-(IBAction)CropAction:(id)sender
{
    
   
    
}


-(IBAction)DoneAction:(id)sender
{
    [photoCropper crop];
    appDel.iconImage=self.croppedPhoto;
    [self.navigationController popViewControllerAnimated:YES];
    //[self.navigationController pushViewController:obj animated:YES];    
}




@end
