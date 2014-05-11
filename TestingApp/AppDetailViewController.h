//
//  AppDetailViewController.h
//  TestingApp
//
//  Created by Nishant kumar on 10/05/14.
//  Copyright (c) 2014 Angelhack. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDetailViewController : UIViewController
{
    IBOutlet UIView *titleView;
    IBOutlet UIImageView *appImgView;
    IBOutlet UILabel *titleLbl, *detailLbl;
    IBOutlet UIButton *applyBtn,*submitBtn, *completeBtn;
    IBOutlet UIScrollView *scroll;
}

@property(nonatomic,retain)NSString *typeName;
@property(nonatomic,retain)NSString *indexNo;


-(void)setTypeName:(NSString *)type IndexNo:(NSString *)Num;
-(IBAction)applyAction:(id)sender;
-(IBAction)submitBtn:(id)sender;
@end
