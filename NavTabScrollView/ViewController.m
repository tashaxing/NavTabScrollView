//
//  ViewController.m
//  NavTabScrollView
//
//  Created by tashaxing on 9/15/16.
//  Copyright © 2016 tashaxing. All rights reserved.
//

#import "ViewController.h"
#import "NavTabViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // 添加子view
    NavTabViewController *navTabViewController = [[NavTabViewController alloc] init];
    // 添加child viewcontroller使其响应事件
    [self addChildViewController:navTabViewController];
    [self.view addSubview:navTabViewController.view];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
