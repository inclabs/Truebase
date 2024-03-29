//
//  AppDelegate.h
//  TestingApp
//
//  Created by Nishant kumar on 10/05/14.
//  Copyright (c) 2014 Angelhack. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, strong) UINavigationController *myNav;

@property (nonatomic, retain)NSString *uid;

@property(nonatomic,strong) UIImage *iconImage;

@property(nonatomic, retain)NSMutableArray *IosNameArr, *AndroidNameArr;

@property(nonatomic, retain)NSMutableArray *IosDetailArr, *AndroidDetailArr;

@property(nonatomic, retain)NSMutableArray *IosImageArr, *AndroidImageArr;

@end
