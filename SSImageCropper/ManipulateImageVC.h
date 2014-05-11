//
//  ManipulateImageVC.h
//  MakeNewHeadlineApp
//
//  Created by Apple on 06/12/12.
//  Copyright (c) 2012 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SSPhotoCropperViewController.h"


@interface ManipulateImageVC : UIViewController <SSPhotoCropperDelegate>
{
    SSPhotoCropperViewController *photoCropper;
    UIImage *photo;
    UIImage *croppedPhoto;
}

@property (nonatomic, retain) UIImage *photo;
@property (nonatomic, retain) UIImage *croppedPhoto;

-(IBAction)CropAction:(id)sender;
-(IBAction)DoneAction:(id)sender;

@end
