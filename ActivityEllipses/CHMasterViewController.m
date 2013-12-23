//
//  CHMasterViewController.m
//  ActivityEllipses
//
//  Created by Chris O'Neil on 12/22/13.
//  Copyright (c) 2013 Chris O'Neil. All rights reserved.
//

#import "CHMasterViewController.h"

@interface CHMasterViewController ()

@end

@implementation CHMasterViewController

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
    self.view.backgroundColor = [UIColor blackColor];
    self.activityView = [[CHActivityEllipses alloc] initWithSize:100.0 backgroundColor:[UIColor whiteColor] dotColor:[UIColor orangeColor]];
    [self.view addSubview:self.activityView];

    UIButton *startActivityButton = [[UIButton alloc] initWithFrame:CGRectMake(kWidth / 5, 40, kWidth / 5, 40)];
    UIButton *stopActivityButton = [[UIButton alloc] initWithFrame:CGRectMake(kWidth / 5 * 3, 40, kWidth / 5, 40)];
    
    [startActivityButton addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchDown];
    [stopActivityButton addTarget:self action:@selector(stop) forControlEvents:UIControlEventTouchDown];
    
    startActivityButton.titleLabel.textColor = [UIColor whiteColor];
    startActivityButton.backgroundColor = [UIColor greenColor];
    startActivityButton.titleLabel.text = @"Start";
    stopActivityButton.titleLabel.textColor = [UIColor whiteColor];
    stopActivityButton.backgroundColor = [UIColor redColor];
    stopActivityButton.titleLabel.text = @"Stop";
    
    [self.view addSubview:startActivityButton];
    [self.view addSubview:stopActivityButton];
}

-(void)start {
    NSLog(@"Starting activity");
    [self.activityView startActivity];
}

-(void)stop {
    NSLog(@"Stopping activity");
    [self.activityView stopActivity];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
