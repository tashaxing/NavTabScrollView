//
//  NavTabViewController.m
//  NavTabScrollView
//
//  Created by tashaxing on 9/15/16.
//  Copyright © 2016 tashaxing. All rights reserved.
//

#import "NavTabViewController.h"
#import "PageViewController.h"

// 常量
#define kFrameWidth self.view.frame.size.width
#define kFrameHeight self.view.frame.size.height

static const CGFloat kUpMargin = 30; // 顶部间距
static const CGFloat kTitleHeight = 50; // 标题高度
static const CGFloat kButtonWidth = 80; // 导航按钮宽度
static const CGFloat kButtonLineHeight = 5; // 小横线高度

@interface NavTabViewController ()<UIScrollViewDelegate>
{
    UIScrollView *_titleScrollView;    // 标题栏
    UIScrollView *_contentScrollview;  // 内容区
    UIView *_buttonLine;               // 标题小横线
    NSInteger _pageCount;              // 分页数
}

@end

@implementation NavTabViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createTitleScrollView];
    [self createButtonLine];
    [self createContentScrollview];
}

#pragma mark - 初始化UI
- (void)createTitleScrollView
{
    // 根据是否有导航栏调整坐标
    CGFloat marginY = self.navigationController ? self.navigationController.view.frame.size.height : kUpMargin;
    
    // 标题栏
    _titleScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, marginY, kFrameWidth, kTitleHeight)];
    _titleScrollView.showsHorizontalScrollIndicator = NO;
    _titleScrollView.bounces = NO;
    _titleScrollView.delegate = self;
    [self.view addSubview:_titleScrollView];
    
    // 添加button
    NSArray *titleArray = @[@"头条", @"社会", @"财经", @"科技", @"体育", @"娱乐", @"时尚", @"军事", @"教育", @"游戏"];
    _pageCount = titleArray.count;
    _titleScrollView.contentSize = CGSizeMake(kButtonWidth * _pageCount, kTitleHeight);
    for (int i = 0; i < _pageCount; i++)
    {
        UIButton *titleBtn = [[UIButton alloc] initWithFrame:CGRectMake(kButtonWidth * i, 0, kButtonWidth, kTitleHeight)];
        [titleBtn setTitle:titleArray[i] forState:UIControlStateNormal];
        [titleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        titleBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [titleBtn addTarget:self action:@selector(titleButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        titleBtn.tag = 1000 + i; // button做标记，方便后面索引，为了不出冲突，就把这个数值设得大一些
        [_titleScrollView addSubview:titleBtn];
    };
}

- (void)createButtonLine
{
    CGFloat marginY = self.navigationController ? self.navigationController.view.frame.size.height : kUpMargin;
    // 初始时刻停在最左边与按钮对齐
    _buttonLine = [[UIView alloc] initWithFrame:CGRectMake(0, marginY + kTitleHeight - kButtonLineHeight, kButtonWidth, kButtonLineHeight)];
    _buttonLine.backgroundColor = [UIColor redColor];
    [self.view addSubview:_buttonLine];
}

- (void)createContentScrollview
{
    CGFloat marginY = self.navigationController ? self.navigationController.view.frame.size.height : kUpMargin;
    
    // 添加内容页面
    _contentScrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, marginY + kTitleHeight, kFrameWidth, kFrameHeight - marginY - kTitleHeight)];
    _contentScrollview.pagingEnabled = YES;
    _contentScrollview.bounces = NO;
    _contentScrollview.contentSize = CGSizeMake(kFrameWidth * _pageCount, kFrameHeight - marginY - kTitleHeight);
    _contentScrollview.showsHorizontalScrollIndicator = NO;
    _contentScrollview.delegate = self;
    [self.view addSubview:_contentScrollview];
    
    // 添加分页面
    for (int i = 0; i < _pageCount; i++)
    {
        PageViewController *pageViewController = [[PageViewController alloc] init];
        UIButton *button = [_contentScrollview viewWithTag:1000 + i];
        pageViewController.title = button.currentTitle;
        pageViewController.view.frame = CGRectMake(kFrameWidth * i, 0, kFrameWidth, kFrameHeight - marginY - kTitleHeight);
        [_contentScrollview addSubview:pageViewController.view];
    }
}

#pragma mark - 标题button点击事件
- (void)titleButtonClicked:(UIButton *)sender
{
    // 根据点击的button切换页面和偏移
    printf("%s clicked\n", sender.currentTitle.UTF8String);
}

#pragma mark - scrollview滑动事件
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 根据content内容偏移调整标题栏
    if (scrollView == _titleScrollView)
    {
        printf("title moved\n");
    }
    else if (scrollView == _contentScrollview)
    {
        printf("content moved\n");
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
