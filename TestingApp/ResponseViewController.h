//
//  ResponseViewController.h
//  TestingApp
//
//  Created by Nishant kumar on 10/05/14.
//  Copyright (c) 2014 Angelhack. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResponseViewController : UIViewController <UITextFieldDelegate>
{
    IBOutlet UIView *titleView;
    IBOutlet UIImageView *appImgView;
    IBOutlet UILabel *titleLbl, *detailLbl;
}

@property(nonatomic,assign)UIColor *color;
@property(nonatomic,retain)NSString *appName, *imageName;

-(void)setColor:(UIColor *)col AppName:(NSString *)name ImageName:(NSString *)imgNm;

-(IBAction)feedbackAction:(id)sender;
-(IBAction)bugsAction:(id)sender;
-(IBAction)reviewbtnAction:(id)sender;

@end
