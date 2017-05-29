//
//  ViewController.m
//  LGDrawBoard
//
//  Created by ligang on 16/6/10.
//  Copyright © 2016年 JJ. All rights reserved.
//

#import "ViewController.h"
#import "LGBoardView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [NSThread sleepForTimeInterval:1];
	LGBoardView *boardView = [[LGBoardView alloc] initWithFrame:self.view.frame];
	boardView.backgroundColor = [UIColor clearColor];
	[self.view addSubview:boardView];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	
	[[UIApplication sharedApplication] setStatusBarHidden:YES];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

@end
