//
//  ViewController.m
//  XSimplePageControl
//
//  Created by LiX i n long on 2018/1/23.
//  Copyright © 2018年 LiX i n long. All rights reserved.
//

#import "ViewController.h"

#import "XSimplePageControl.h"

#define kSelfWidth      self.view.frame.size.width

@interface ViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) XSimplePageControl *basePageControl;
@property (nonatomic, strong) XSimplePageControl *customPageControl;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self initScrollView];
    [self initBaseView];
    [self initCustomView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -

static NSInteger pageNumber = 8;

- (void)initScrollView
{
    UIScrollView *baseScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 100, kSelfWidth, 150)];
    baseScrollView.layer.masksToBounds = YES;
    baseScrollView.backgroundColor = [UIColor redColor];
    baseScrollView.delegate = self;
    baseScrollView.pagingEnabled = YES;
    baseScrollView.contentSize = CGSizeMake(kSelfWidth * pageNumber, 0);
    [self.view addSubview:baseScrollView];
    self.scrollView = baseScrollView;

    for (int i = 0; i < pageNumber; i++) {
        CGRect frame = baseScrollView.bounds;
        frame.origin.x = i * baseScrollView.bounds.size.width;
        UIView *showView = [[UIView alloc] initWithFrame:frame];
        showView.backgroundColor = [UIColor colorWithRed:arc4random() % 256 / 255.0 green:arc4random() % 256 / 255.0 blue:arc4random() % 256 / 255.0 alpha:1];
        [baseScrollView addSubview:showView];
    }
}

- (void)initBaseView
{
    self.basePageControl = [[XSimplePageControl alloc] initWithFrame:CGRectMake(0, 250, kSelfWidth, 50)];
    self.basePageControl.pageNumber = pageNumber;
    [self setClickBlcok:self.basePageControl];
    [self.view addSubview:self.basePageControl];
}

- (void)initCustomView
{
    self.customPageControl = [[XSimplePageControl alloc] initWithFrame:CGRectMake(0, 300, kSelfWidth, 50)];
    self.customPageControl.pageNumber = pageNumber;
    self.customPageControl.controlSize = 10;
    self.customPageControl.controlSelectedSize = 30;
    self.customPageControl.controlColor = [UIColor redColor];
    self.customPageControl.controlSelectedColor = [UIColor orangeColor];
    self.customPageControl.controlSpacing = 10;
    self.customPageControl.animationTime = 1.f;
    [self setClickBlcok:self.customPageControl];
    [self.view addSubview:self.customPageControl];
}

- (void)setClickBlcok:(XSimplePageControl *)pageControl
{
    __weak typeof(self)weakself = self;
    pageControl.controlSelect = ^(XSimplePageControl *pageControl, NSUInteger index) {
        __strong typeof(self)strongself = weakself;
        CGPoint offset = CGPointMake(strongself.scrollView.frame.size.width * index, 0);
        [strongself.scrollView setContentOffset:offset animated:YES];
    };
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidStop:scrollView];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [self scrollViewDidStop:scrollView];
}

#pragma mark - private

- (void)scrollViewDidStop:(UIScrollView *)scrollView
{
    NSInteger index = scrollView.contentOffset.x / scrollView.frame.size.width;
    self.basePageControl.currentPage = index;
    self.customPageControl.currentPage = index;
}

@end
