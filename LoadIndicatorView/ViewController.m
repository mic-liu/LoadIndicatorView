//
//  ViewController.m
//  LoadIndicatorView
//
//  Created by LiuMingchuan on 15/10/14.
//  Copyright © 2015年 LMC. All rights reserved.
//

#import "ViewController.h"
#import "LMCLoadIndicatorView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    LMCLoadIndicatorView *indicatorView = [[LMCLoadIndicatorView alloc]initWithFrame:CGRectMake(10, 164, 50, 50)];
    indicatorView.center = self.view.center;
    [self.view addSubview:indicatorView];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
