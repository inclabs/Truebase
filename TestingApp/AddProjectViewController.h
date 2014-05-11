//
//  AddProjectViewController.h
//  TestingApp
//
//  Created by Nishant kumar on 11/05/14.
//  Copyright (c) 2014 Angelhack. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddProjectViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
{
    IBOutlet UIImageView *headerView;
    IBOutlet UIImageView *iconImgView;
    IBOutlet UITextField *nameTF, *categoryTF, *tagsTF, *socialLinkTF;
    IBOutlet UITextView *discriptionTV;
    IBOutlet UIScrollView *scroll;
    
}

@property(nonatomic,retain)NSString *typeName;

-(void)setTypeName:(NSString *)type;

-(IBAction)submitButtonAction:(id)sender;
@end
