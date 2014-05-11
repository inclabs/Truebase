//
//  MainViewController.h
//  TestingApp
//
//  Created by Nishant kumar on 10/05/14.
//  Copyright (c) 2014 Angelhack. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    IBOutlet UIImageView *titleImage;
    IBOutlet UITableView *contentTbl;
    IBOutlet UILabel *titleLbl;
}
@property(nonatomic,retain) NSString *tableName;

-(IBAction)AddProjAction:(id)sender;
@end
