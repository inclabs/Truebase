//
//  AppDetailViewController.m
//  TestingApp
//
//  Created by Nishant kumar on 10/05/14.
//  Copyright (c) 2014 Angelhack. All rights reserved.
//

#import "AppDetailViewController.h"
#import "ResponseViewController.h"
#import "LogInViewController.h"
#import "AppDelegate.h"

@interface AppDetailViewController ()
{
    int index;
    NSUserDefaults *userdef;
    NSArray *nameArr, *detailArr, *imgArr;
    UIColor *currentColor;
    AppDelegate *appDel;
    BOOL isApplied;
}
@end

@implementation AppDetailViewController
@synthesize typeName, indexNo;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)setTypeName:(NSString *)type IndexNo:(NSString *)Num
{
    typeName=type;
    indexNo=Num;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    appDel=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    nameArr=[[NSArray alloc]init];
    detailArr=[[NSArray alloc]init];
    imgArr=[[NSArray alloc]init];
    userdef=[NSUserDefaults standardUserDefaults];
    index=[indexNo intValue];
    [applyBtn setTitle:@"Apply" forState:UIControlStateNormal];
    //[applyBtn removeTarget:self action:@selector(appliedAction:) forControlEvents:UIControlEventTouchUpInside];
    [applyBtn setUserInteractionEnabled:YES];
    NSLog(@"typeName %@ and index_is %d",typeName,index);
    
        NSString *keyName=[NSString stringWithFormat:@"%@NameArr",typeName];
        nameArr=[userdef valueForKey:keyName];
        NSString *keyDetail=[NSString stringWithFormat:@"%@DetailArr",typeName];
        detailArr=[userdef valueForKey:keyDetail];
        NSString *keyImg=[NSString stringWithFormat:@"%@ImageArr",typeName];
        imgArr=[userdef valueForKey:keyImg];

    UISwipeGestureRecognizer *leftSwipe=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handelLeftSwipe:)];
    [leftSwipe setDirection:UISwipeGestureRecognizerDirectionLeft];
    [self.view addGestureRecognizer:leftSwipe];
    
    [self createAppView];
}
-(void)viewWillAppear:(BOOL)animated
{
    appImgView.image=appDel.iconImage;
    NSLog(@"appDelIcon %@",appDel.iconImage);
    [self.navigationController setNavigationBarHidden:YES];
}

-(void)handelLeftSwipe:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)createAppView
{
    if ([typeName isEqualToString:@"Ios"]) {
        currentColor=[UIColor colorWithRed:180.0/255.0 green:112.0/255.0 blue:69.0/255.0 alpha:1];
        [titleView setBackgroundColor:currentColor];
    }else{
        [titleView setBackgroundColor:[UIColor colorWithRed:99.0/255.0 green:102.0/255.0 blue:180.0/255.0 alpha:1]];
        currentColor=[UIColor colorWithRed:99.0/255.0 green:102.0/255.0 blue:180.0/255.0 alpha:1];
    }
    
    titleLbl.text=[nameArr objectAtIndex:index];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *imgName=[NSString stringWithFormat:@"%@",[imgArr objectAtIndex:index]];
    NSString *imgPath=[documentsDirectory stringByAppendingString:imgName];
    UIImage *tempImage=[UIImage imageWithContentsOfFile:imgPath];
    if (tempImage) {
        appImgView.image=tempImage;
    }else{
        appImgView.image=[UIImage imageNamed:@"Unknown.png"];
    }
    
    detailLbl.text=[detailArr objectAtIndex:index];
    int xPoint =40;
    [scroll.subviews makeObjectsPerformSelector: @selector(removeFromSuperview)];

    
    for (int i=0; i<[imgArr count]; i++) {
        if (i!=index) {
            UIButton *similarBtn=[[UIButton alloc]initWithFrame:CGRectMake(xPoint, 10, 60,60)];
            NSString *imgName=[NSString stringWithFormat:@"%@",[imgArr objectAtIndex:i]];
            NSString *imgPath=[documentsDirectory stringByAppendingString:imgName];
            UIImage *tempImage=[UIImage imageWithContentsOfFile:imgPath];
            if (tempImage) {
                [similarBtn setImage:tempImage forState:UIControlStateNormal];
            }else{
                [similarBtn setImage:[UIImage imageNamed:[imgArr objectAtIndex:i]] forState:UIControlStateNormal];
            }
            
            [similarBtn setTag:i];
            [similarBtn addTarget:self action:@selector(similarAction:) forControlEvents:UIControlEventTouchUpInside];
            xPoint=xPoint+80;
            [scroll addSubview:similarBtn];
        }
    }
    [scroll setContentSize:CGSizeMake(xPoint, 80)];
}


#pragma UIButton Action
-(IBAction)similarAction:(id)sender
{
    index=[sender tag];
    [self createAppView];
    NSLog(@"btn Index %d",[sender tag]);
}
-(IBAction)applyAction:(id)sender
{
    NSString *uid=appDel.uid;
    if (uid.length>0) {
        if (isApplied) {
            [applyBtn setHidden:NO];
            [applyBtn setTitle:@"Applied" forState:UIControlStateNormal];
            [applyBtn removeTarget:self action:@selector(applyAction:) forControlEvents:UIControlEventTouchUpInside];
            [applyBtn addTarget:self action:@selector(appliedAction:) forControlEvents:UIControlEventTouchUpInside];
            
        }
        [applyBtn setHidden:NO];
        [submitBtn setHidden:YES];
        [completeBtn setHidden:YES];
    }else{
        isApplied=YES;
        LogInViewController *login=[[LogInViewController alloc]initWithNibName:@"LogInViewController" bundle:nil];
        //[self presentViewController:login animated:YES completion:nil];
        [self.navigationController pushViewController:login animated:YES];
    }
//    [applyBtn setHidden:YES];
//    [submitBtn setHidden:NO];
//    [completeBtn setHidden:NO];
    
}
-(IBAction)appliedAction:(id)sender
{
    [applyBtn setHidden:YES];
    [submitBtn setHidden:NO];
    [completeBtn setHidden:NO];
}
-(IBAction)submitBtn:(id)sender
{
    ResponseViewController *obj=[[ResponseViewController alloc]initWithNibName:@"ResponseViewController" bundle:nil];
    [obj setColor:currentColor AppName:titleLbl.text ImageName:[imgArr objectAtIndex:index]];
    [self.navigationController pushViewController:obj animated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
