//
//  MainViewController.m
//  TestingApp
//
//  Created by Nishant kumar on 10/05/14.
//  Copyright (c) 2014 Angelhack. All rights reserved.
//

#import "MainViewController.h"
#import "AppDetailViewController.h"
#import "AddProjectViewController.h"
#import "AppDelegate.h"

@interface MainViewController ()
{
    int leftScr;
    NSMutableArray *IosNameArr, *AndroidNameArr;
    NSMutableArray *IosDetailArr, *AndroidDetailArr;
    NSMutableArray *IosImageArr, *AndroidImageArr;
    UIColor *currentColor;
    AppDelegate *appDel;
    NSUserDefaults *userdef;
}
@end

@implementation MainViewController

@synthesize tableName;

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
    userdef=[NSUserDefaults standardUserDefaults];
    appDel=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    leftScr=0;
    titleLbl.text=@"IOS Application";
    tableName=@"Ios";
//    contentTbl.dataSource=self;
//    contentTbl.delegate=self;
    currentColor=[UIColor colorWithRed:180.0/255.0 green:112.0/255.0 blue:69.0/255.0 alpha:1];
    titleImage.backgroundColor=currentColor;
    UISwipeGestureRecognizer *leftSwipe=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handelLeftSwipe:)];
    [leftSwipe setDirection:UISwipeGestureRecognizerDirectionLeft];
    [self.view addGestureRecognizer:leftSwipe];
    
    UISwipeGestureRecognizer *rightSwipe=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handelRightSwipe:)];
    [rightSwipe setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.view addGestureRecognizer:rightSwipe];
    
    //IosNameArr=[[NSMutableArray alloc]initWithObjects:@"Filmojo",@"stepINGift",@"stepINKrd", nil];
    IosNameArr=[[NSMutableArray alloc]initWithArray:appDel.IosNameArr];
    [userdef setValue:IosNameArr forKeyPath:@"IosNameArr"];
    
    //IosDetailArr=[[NSMutableArray alloc]initWithObjects:@"Socialise you film interest. Get detail of your favourite movies with rating and review. Get Alert for your wishlist. Find the movies playing in your city.",@"Now creating, sharing, holding and managing gift coupons is easier than easiest. Feel your business growing rate. Easy to create attarctive coupons.",@"Generate your own digital business card using your mobile. It makes easer Sharing, Carrying and Remembering.", nil];
    IosDetailArr=[[NSMutableArray alloc]initWithArray:appDel.IosDetailArr];
    [userdef setValue:IosDetailArr forKeyPath:@"IosDetailArr"];
    
    //IosImageArr=[[NSMutableArray alloc]initWithObjects:@"Filmojo.png",@"stepINGift.png",@"stepINKrd.png", nil];
    IosImageArr=[[NSMutableArray alloc]initWithArray:appDel.IosImageArr];
    [userdef setValue:IosImageArr forKeyPath:@"IosImageArr"];

    
    AndroidNameArr=[[NSMutableArray alloc]initWithObjects:@"Gamojo",@"Fly Chicky Fly", nil];
    [userdef setValue:AndroidNameArr forKeyPath:@"AndroidNameArr"];
    
    AndroidDetailArr=[[NSMutableArray alloc]initWithObjects:@"A Platform where you can socialise you game interest, it makes your game more interesting. Get update with you favouraite team or player.",@"Very interesting kid game on Android platform. Touch hold or down to make the movement of your chicky.", nil];
    [userdef setValue:AndroidDetailArr forKeyPath:@"AndroidDetailArr"];
    
    AndroidImageArr=[[NSMutableArray alloc]initWithObjects:@"gamojo.png",@"fly.png", nil];
    [userdef setValue:AndroidImageArr forKeyPath:@"AndroidImageArr"];
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES];
    [self.view setBackgroundColor:[currentColor colorWithAlphaComponent:0.3]];
    IosNameArr=[[NSMutableArray alloc]initWithArray:appDel.IosNameArr];
    [userdef setValue:IosNameArr forKeyPath:@"IosNameArr"];
    IosDetailArr=[[NSMutableArray alloc]initWithArray:appDel.IosDetailArr];
    [userdef setValue:IosDetailArr forKeyPath:@"IosDetailArr"];
    IosImageArr=[[NSMutableArray alloc]initWithArray:appDel.IosImageArr];
    [userdef setValue:IosImageArr forKeyPath:@"IosImageArr"];
    
    [contentTbl reloadData];
    
    NSLog(@"AppDel IOS Arr %@",appDel.IosNameArr);
}

#pragma Methods Implementation for Swipe

-(void)handelLeftSwipe:(id)sender
{
    if (leftScr==0) {
        titleLbl.text=@"Android Application";
        leftScr=1;
        tableName=@"Android";
        currentColor=[UIColor colorWithRed:99.0/255.0 green:102.0/255.0 blue:180.0/255.0 alpha:1];
        titleImage.backgroundColor=currentColor;
        [self.view setBackgroundColor:[currentColor colorWithAlphaComponent:0.3]];
        [contentTbl reloadData];
    }
}

-(void)handelRightSwipe:(id)sender
{
    if (leftScr==1) {
        titleLbl.text=@"IOS Application";
        [contentTbl setAccessibilityLabel:@"ios"];
        leftScr=0;
        tableName=@"Ios";
        currentColor=[UIColor colorWithRed:180.0/255.0 green:112.0/255.0 blue:69.0/255.0 alpha:1];
        titleImage.backgroundColor=currentColor;
        [self.view setBackgroundColor:[currentColor colorWithAlphaComponent:0.3]];
        [contentTbl reloadData];
    }

}

#pragma TableViewDelegate Method
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"height");
    return 100;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int rowCount=1;
    if ([tableName isEqualToString:@"Ios"]) {
        rowCount=[IosNameArr count];
    }else if ([tableName isEqualToString:@"Android"]){
        rowCount=[AndroidNameArr count];
    }
    NSLog(@"count %d tableName %@",rowCount, tableName);
    return rowCount;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"cell row");
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:nil];
    UIImageView *imgView;
    UILabel *titleTxtLbl;
    UILabel *detailLbl;
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        [cell.detailTextLabel setNumberOfLines:2];
        titleTxtLbl=[[UILabel alloc]initWithFrame:CGRectMake(75, 10, 220, 30)];
        titleTxtLbl.font=[UIFont fontWithName:@"Helvetica Bold" size:18];
        detailLbl=[[UILabel alloc]initWithFrame:CGRectMake(75, 35, 220, 60)];
        [detailLbl setNumberOfLines:2];
        imgView=[[UIImageView alloc]initWithFrame:CGRectMake(5, 20, 60, 60)];
    }
    
    if ([tableName isEqualToString:@"Ios"]) {
        titleTxtLbl.text=[IosNameArr objectAtIndex:indexPath.row];
        detailLbl.text=[IosDetailArr objectAtIndex:indexPath.row];
        
        NSString* fileName = [NSString stringWithFormat:@"%@",[IosImageArr objectAtIndex:indexPath.row]];
        NSArray *arrayPaths =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
        NSString *path = [arrayPaths objectAtIndex:0];
        NSString* pdfFileName = [path stringByAppendingPathComponent:fileName];
                              
        UIImage *image1=[UIImage imageWithContentsOfFile:pdfFileName];
        
        if (image1) {
            imgView.image=image1;
        }else{
            imgView.image=[UIImage imageNamed:@"Unkown.png"];
        }
    }
    if ([tableName isEqualToString:@"Android"]) {
        titleTxtLbl.text=[AndroidNameArr objectAtIndex:indexPath.row];
        detailLbl.text=[AndroidDetailArr objectAtIndex:indexPath.row];
        
        imgView.image=[UIImage imageNamed:[AndroidImageArr objectAtIndex:indexPath.row]];
    }
    [cell addSubview:titleTxtLbl];
    [cell addSubview:detailLbl];
    [cell addSubview:imgView];
    [cell setBackgroundColor:[UIColor clearColor]];
    [contentTbl setSeparatorColor:currentColor];
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AppDetailViewController *detail=[[AppDetailViewController alloc]initWithNibName:@"AppDetailViewController" bundle:nil];
    [detail setTypeName:tableName IndexNo:[NSString stringWithFormat:@"%d",indexPath.row]];
    [self.navigationController pushViewController:detail animated:YES];
}

#pragma UIButton Action
-(IBAction)AddProjAction:(id)sender
{
    AddProjectViewController *add=[[AddProjectViewController alloc]initWithNibName:@"AddProjectViewController" bundle:nil];
    //[self presentViewController:add animated:YES completion:nil];
    [self.navigationController pushViewController:add animated:YES];

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
