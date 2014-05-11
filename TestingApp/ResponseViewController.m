//
//  ResponseViewController.m
//  TestingApp
//
//  Created by Nishant kumar on 10/05/14.
//  Copyright (c) 2014 Angelhack. All rights reserved.
//

#import "ResponseViewController.h"

@interface ResponseViewController ()
{
    BOOL ratone;
    BOOL rattwo;
    BOOL ratthree;
    BOOL ratfour;
    BOOL ratfive;
    int ratingvalue;
    int reviewNo, bugViewCount, xPoint;
    IBOutlet UIButton *btn1,*btn2,*btn3,*btn4,*btn5, *addbugViewBtn;
    NSString *placeholderText;
    IBOutlet UITextView *addReviewTxtView;
    UIToolbar *toolbar;
    UIView *bugView;
    UIScrollView *scroll;
    UITextField *bugTitleTF, *bugDetailTF;
}
@end

@implementation ResponseViewController
@synthesize color, appName, imageName;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)setColor:(UIColor *)col AppName:(NSString *)name ImageName:(NSString *)imgNm
{
    color=col;
    appName=name;
    imageName=imgNm;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    bugViewCount=0; xPoint=0;
    [titleView setBackgroundColor:color];
    appImgView.image=[UIImage imageNamed:imageName];
    titleLbl.text=appName;
    placeholderText=@"Put Your Review Text here.";
    addReviewTxtView.text=placeholderText;
    
    addReviewTxtView.layer.borderColor=[[UIColor lightGrayColor]CGColor];
    addReviewTxtView.layer.borderWidth=1.0f;
    addReviewTxtView.layer.cornerRadius=6.0;
    
    /////toolbar for TextView
    toolbar=[[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    UIBarButtonItem *flexbtn=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem *donebtn=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(hideKeyboard:)];
    NSArray *arr=[NSArray arrayWithObjects:flexbtn,donebtn,nil];
    [toolbar setItems:arr];
    
    
}

#pragma UIButton Action
-(IBAction)reviewbtnAction:(id)sender
{
    UIButton *currentBtn=(UIButton *)sender;
    NSInteger tag=[currentBtn tag];
    
    reviewNo=tag;
    if (reviewNo==5) {
        if (ratfive) {
            [btn1 setImage:[UIImage imageNamed:@"star_icon.png"] forState:UIControlStateNormal];
            [btn2 setImage:[UIImage imageNamed:@"star_icon.png"] forState:UIControlStateNormal];
            [btn3 setImage:[UIImage imageNamed:@"star_icon.png"] forState:UIControlStateNormal];
            [btn4 setImage:[UIImage imageNamed:@"star_icon.png"] forState:UIControlStateNormal];
            [btn5 setImage:[UIImage imageNamed:@"star_icon.png"] forState:UIControlStateNormal];
            ratfive=NO; ratfour=NO; ratthree=NO; rattwo=NO; ratone=NO; reviewNo=0;
        }else{
            [btn1 setImage:[UIImage imageNamed:@"star_fav.png"] forState:UIControlStateNormal];
            [btn2 setImage:[UIImage imageNamed:@"star_fav.png"] forState:UIControlStateNormal];
            [btn3 setImage:[UIImage imageNamed:@"star_fav.png"] forState:UIControlStateNormal];
            [btn4 setImage:[UIImage imageNamed:@"star_fav.png"] forState:UIControlStateNormal];
            [btn5 setImage:[UIImage imageNamed:@"star_fav.png"] forState:UIControlStateNormal];
            ratfive=YES; ratfour=NO; ratthree=NO; rattwo=NO; ratone=NO;
        }
        
    }else if (reviewNo==4){
        if (ratfour) {
            [btn1 setImage:[UIImage imageNamed:@"star_icon.png"] forState:UIControlStateNormal];
            [btn2 setImage:[UIImage imageNamed:@"star_icon.png"] forState:UIControlStateNormal];
            [btn3 setImage:[UIImage imageNamed:@"star_icon.png"] forState:UIControlStateNormal];
            [btn4 setImage:[UIImage imageNamed:@"star_icon.png"] forState:UIControlStateNormal];
            [btn5 setImage:[UIImage imageNamed:@"star_icon.png"] forState:UIControlStateNormal];
            ratfive=NO; ratfour=NO; ratthree=NO; rattwo=NO; ratone=NO; reviewNo=0;
        }else{
            [btn1 setImage:[UIImage imageNamed:@"star_fav.png"] forState:UIControlStateNormal];
            [btn2 setImage:[UIImage imageNamed:@"star_fav.png"] forState:UIControlStateNormal];
            [btn3 setImage:[UIImage imageNamed:@"star_fav.png"] forState:UIControlStateNormal];
            [btn4 setImage:[UIImage imageNamed:@"star_fav.png"] forState:UIControlStateNormal];
            [btn5 setImage:[UIImage imageNamed:@"star_icon.png"] forState:UIControlStateNormal];
            ratfive=NO; ratfour=YES; ratthree=NO; rattwo=NO; ratone=NO;
        }
        
    }else if (reviewNo==3){
        if (ratthree) {
            [btn1 setImage:[UIImage imageNamed:@"star_icon.png"] forState:UIControlStateNormal];
            [btn2 setImage:[UIImage imageNamed:@"star_icon.png"] forState:UIControlStateNormal];
            [btn3 setImage:[UIImage imageNamed:@"star_icon.png"] forState:UIControlStateNormal];
            [btn4 setImage:[UIImage imageNamed:@"star_icon.png"] forState:UIControlStateNormal];
            [btn5 setImage:[UIImage imageNamed:@"star_icon.png"] forState:UIControlStateNormal];
            ratfive=NO; ratfour=NO; ratthree=NO; rattwo=NO; ratone=NO; reviewNo=0;
        }else{
            [btn1 setImage:[UIImage imageNamed:@"star_fav.png"] forState:UIControlStateNormal];
            [btn2 setImage:[UIImage imageNamed:@"star_fav.png"] forState:UIControlStateNormal];
            [btn3 setImage:[UIImage imageNamed:@"star_fav.png"] forState:UIControlStateNormal];
            [btn4 setImage:[UIImage imageNamed:@"star_icon.png"] forState:UIControlStateNormal];
            [btn5 setImage:[UIImage imageNamed:@"star_icon.png"] forState:UIControlStateNormal];
            ratfive=NO; ratfour=NO; ratthree=YES; rattwo=NO; ratone=NO;
        }
        
    }else if (reviewNo==2){
        if (rattwo) {
            [btn1 setImage:[UIImage imageNamed:@"star_icon.png"] forState:UIControlStateNormal];
            [btn2 setImage:[UIImage imageNamed:@"star_icon.png"] forState:UIControlStateNormal];
            [btn3 setImage:[UIImage imageNamed:@"star_icon.png"] forState:UIControlStateNormal];
            [btn4 setImage:[UIImage imageNamed:@"star_icon.png"] forState:UIControlStateNormal];
            [btn5 setImage:[UIImage imageNamed:@"star_icon.png"] forState:UIControlStateNormal];
            ratfive=NO; ratfour=NO; ratthree=NO; rattwo=NO; ratone=NO; reviewNo=0;
        }else{
            [btn1 setImage:[UIImage imageNamed:@"star_fav.png"] forState:UIControlStateNormal];
            [btn2 setImage:[UIImage imageNamed:@"star_fav.png"] forState:UIControlStateNormal];
            [btn3 setImage:[UIImage imageNamed:@"star_icon.png"] forState:UIControlStateNormal];
            [btn4 setImage:[UIImage imageNamed:@"star_icon.png"] forState:UIControlStateNormal];
            [btn5 setImage:[UIImage imageNamed:@"star_icon.png"] forState:UIControlStateNormal];
            ratfive=NO; ratfour=NO; ratthree=NO; rattwo=YES; ratone=NO;
        }
        
    }else if (reviewNo==1){
        if (ratone) {
            [btn1 setImage:[UIImage imageNamed:@"star_icon.png"] forState:UIControlStateNormal];
            [btn2 setImage:[UIImage imageNamed:@"star_icon.png"] forState:UIControlStateNormal];
            [btn3 setImage:[UIImage imageNamed:@"star_icon.png"] forState:UIControlStateNormal];
            [btn4 setImage:[UIImage imageNamed:@"star_icon.png"] forState:UIControlStateNormal];
            [btn5 setImage:[UIImage imageNamed:@"star_icon.png"] forState:UIControlStateNormal];
            ratfive=NO; ratfour=NO; ratthree=NO; rattwo=NO; ratone=NO; reviewNo=0;
        }else{
            [btn1 setImage:[UIImage imageNamed:@"star_fav.png"] forState:UIControlStateNormal];
            [btn2 setImage:[UIImage imageNamed:@"star_icon.png"] forState:UIControlStateNormal];
            [btn3 setImage:[UIImage imageNamed:@"star_icon.png"] forState:UIControlStateNormal];
            [btn4 setImage:[UIImage imageNamed:@"star_icon.png"] forState:UIControlStateNormal];
            [btn5 setImage:[UIImage imageNamed:@"star_icon.png"] forState:UIControlStateNormal];
            ratfive=NO; ratfour=NO; ratthree=NO; rattwo=NO; ratone=YES;
        }
        
    }else if (reviewNo==0){
        [btn1 setImage:[UIImage imageNamed:@"star_icon.png"] forState:UIControlStateNormal];
        [btn2 setImage:[UIImage imageNamed:@"star_icon.png"] forState:UIControlStateNormal];
        [btn3 setImage:[UIImage imageNamed:@"star_icon.png"] forState:UIControlStateNormal];
        [btn4 setImage:[UIImage imageNamed:@"star_icon.png"] forState:UIControlStateNormal];
        [btn5 setImage:[UIImage imageNamed:@"star_icon.png"] forState:UIControlStateNormal];
        ratfive=NO; ratfour=NO; ratthree=NO; rattwo=NO; ratone=NO;
    }
}

#pragma UIButton Method
-(IBAction)feedbackAction:(id)sender
{
    
}
-(IBAction)bugsAction:(id)sender
{
    UIView *doneView=[[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-60, 320, 60)];
    [doneView setBackgroundColor:[UIColor blueColor]];
    
    UIButton *skipBtn=[[UIButton alloc]initWithFrame:CGRectMake(40, 10, 100, 40)];
    [skipBtn setTitle:@"Skip" forState:UIControlStateNormal];
    [skipBtn addTarget:self action:@selector(skipAction:) forControlEvents:UIControlEventTouchUpInside];
    [doneView addSubview:skipBtn];
    [self.view addSubview:doneView];
    scroll=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 220, 320, self.view.frame.size.height-280)];
    [scroll setBackgroundColor:[UIColor darkGrayColor]];
    [self.view addSubview:scroll];
    
    
    [self createBugView];
    
}
-(IBAction)skipAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(IBAction)addbugViewAction:(id)sender
{
    bugViewCount=bugViewCount+1;
    [self createBugView];
}
-(void)createBugView
{
    xPoint=110*bugViewCount;
    bugView=[[UIView alloc]initWithFrame:CGRectMake(0, xPoint, 320, 100)];
    [bugView setBackgroundColor:[UIColor whiteColor]];
    
    if (bugViewCount==0) {
        addbugViewBtn=[[UIButton alloc]initWithFrame:CGRectMake(210, 5, 100, 20)];
        [addbugViewBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [addbugViewBtn setTitle:@"Add More" forState:UIControlStateNormal];
        [addbugViewBtn setTag:0];
        [addbugViewBtn addTarget:self action:@selector(addbugViewAction:) forControlEvents:UIControlEventTouchUpInside];
        [bugView addSubview:addbugViewBtn];
    }
   
   
    
    bugTitleTF=[[UITextField alloc]initWithFrame:CGRectMake(40, 25, 240, 30)];
    [bugTitleTF setBorderStyle:UITextBorderStyleRoundedRect];
    [bugTitleTF setPlaceholder:@"Bug Title"];
    [bugTitleTF setDelegate:self];
    [bugView addSubview:bugTitleTF];
    
    bugDetailTF=[[UITextField alloc]initWithFrame:CGRectMake(40, 60, 240, 30)];
    [bugDetailTF setDelegate:self];
    [bugDetailTF setPlaceholder:@"Bug Detail"];
    [bugDetailTF setBorderStyle:UITextBorderStyleRoundedRect];
    [bugView addSubview:bugDetailTF];
    [scroll addSubview:bugView];
    
    xPoint=xPoint+120;
    [scroll setContentSize:CGSizeMake(320, xPoint)];
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
    if (addReviewTxtView.text.length==0) {
        addReviewTxtView.text=placeholderText;
    }else{
        //addedReview=addReviewTxtView.text;
    }
    [addReviewTxtView resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
