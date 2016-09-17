//
//  PageViewController.m
//  NavTabScrollView
//
//  Created by tashaxing on 9/15/16.
//  Copyright © 2016 tashaxing. All rights reserved.
//

#import "PageViewController.h"

@interface PageViewController ()

@end

@implementation PageViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 设置背景随机颜色
    int R = (arc4random() % 256);
    int G = (arc4random() % 256);
    int B = (arc4random() % 256);
    self.view.backgroundColor = [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1];
}

// 外部设置标题，重写属性的set函数
- (void)setTitle:(NSString *)title
{
    // 添加label
    UILabel *label = [[UILabel alloc] init];
    label.text = title;
    label.frame = CGRectMake(150, 300, 100, 50);
    [self.view addSubview:label];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
