//
//  FLViewController.m
//  FLStatusBarPopUp
//
//  Created by Frederik Lipfert on 27.05.13.
//  Copyright (c) 2013 Frederik Lipfert. All rights reserved.
//

#import "FLViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface FLViewController ()

@end

@implementation FLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Load FLStatusBarPopUp Singleton
    statusBarPopUpInstance = [FLStatusBarPopUp sharedFLStatusBarPopUp];
    
    // Create UIView
    if ([[UIScreen mainScreen] bounds].size.height == 568)
    {
        UIView *bgr = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 548)];
        bgr.backgroundColor = [UIColor whiteColor];
        bgr.layer.cornerRadius = 10.0f;
        [self.view addSubview:bgr];
    } else
    {
        UIView *bgr = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 498)];
        bgr.backgroundColor = [UIColor whiteColor];
        bgr.layer.cornerRadius = 10.0f;
        [self.view addSubview:bgr];
    }
    
    
    UIView *bgr = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 498)];
    bgr.backgroundColor = [UIColor whiteColor];
    bgr.layer.cornerRadius = 10.0f;
    [self.view addSubview:bgr];
	
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button addTarget:self
               action:@selector(showStatusBarPopUp)
     forControlEvents:UIControlEventTouchDown];
    [button setTitle:@"Show for 3s" forState:UIControlStateNormal];
    button.frame = CGRectMake(80.0, 40, 160.0, 40.0);
    [self.view addSubview:button];
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button2 addTarget:self
                action:@selector(showStatusBarPopUpInfinite)
      forControlEvents:UIControlEventTouchDown];
    [button2 setTitle:@"Show" forState:UIControlStateNormal];
    button2.frame = CGRectMake(80.0, 100, 160.0, 40.0);
    [self.view addSubview:button2];
    
    UIButton *button3 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button3 addTarget:self
                action:@selector(hideStatusBarPopUp)
      forControlEvents:UIControlEventTouchDown];
    [button3 setTitle:@"Hide" forState:UIControlStateNormal];
    button3.frame = CGRectMake(80.0, 160, 160.0, 40.0);
    [self.view addSubview:button3];
    
    UIButton *button4 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button4 addTarget:self
                action:@selector(showStatusBarPopUpPlain)
      forControlEvents:UIControlEventTouchDown];
    [button4 setTitle:@"Show Plain" forState:UIControlStateNormal];
    button4.frame = CGRectMake(80.0, 220, 160.0, 40.0);
    [self.view addSubview:button4];
    
}

-(void)showStatusBarPopUp
{
    [statusBarPopUpInstance showPopUpWithMessage:@"Whatup Mailbox" forDuration:3 stayInfinite:NO withActivityIndicator:YES];
}

-(void)showStatusBarPopUpInfinite
{
    [statusBarPopUpInstance showPopUpWithMessage:@"Whatup Mailbox" forDuration:0 stayInfinite:YES withActivityIndicator:YES];
}

-(void)showStatusBarPopUpPlain
{
    [statusBarPopUpInstance showPopUpWithMessage:@"Whatup Mailbox" forDuration:0 stayInfinite:YES withActivityIndicator:NO];
}

-(void)hideStatusBarPopUp
{
    [statusBarPopUpInstance dismissPopUp];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

