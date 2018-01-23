//
//  XSimplePageControl.m
//  XSimplePageControl
//
//  Created by LiX i n long on 2018/1/23.
//  Copyright © 2018年 LiX i n long. All rights reserved.
//

#import "XSimplePageControl.h"

#define doubleEqual(doubleA, doubleB)       (fabs((doubleA) - (doubleB)) <= pow(10, -4))
#define RGB(r, g, b)        [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]

@implementation XSimplePageControl

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self baseInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self baseInit];
    }
    return self;
}

- (void)layoutSubviews
{
    [self initView];
}

#pragma mark - init

- (void)baseInit
{
    self.pageNumber = 0;
    self.currentPage = 0;
    self.controlSpacing = 4.f;
    self.controlSize = 4.f;
    self.controlSelectedSize = 9.f;
    self.animationTime = 0.25f;
    self.controlColor = RGB(153, 153, 153);
    self.controlSelectedColor = RGB(34, 34, 34);
}

static NSInteger pageControlTag = 555;

- (void)initView
{
    if (self.pageNumber < 2) {
        return;
    }
    if (self.frame.size.height < self.controlSize) {
        return;
    }
    [self clearAllView];
    CGFloat totalWidth = (self.controlSpacing + self.controlSize) * (self.pageNumber - 1) + self.controlSelectedSize;
    if (self.frame.size.width < totalWidth) {
        return;
    }
    CGFloat originX = (self.frame.size.width - totalWidth) / 2;
    CGFloat originY = (self.frame.size.height - self.controlSize) / 2;
    for (int i = 0; i < self.pageNumber; i++) {
        UIButton *control = [UIButton buttonWithType:(UIButtonTypeCustom)];
        control.tag = pageControlTag + i;
        CGFloat controlWidth = self.controlSize;
        control.backgroundColor = self.controlColor;
        if (i == self.currentPage) {
            controlWidth = self.controlSelectedSize;
            control.backgroundColor = self.controlSelectedColor;
        }
        control.frame = CGRectMake(originX, originY, controlWidth, self.controlSize);
        control.layer.cornerRadius = self.controlSize / 2;
        [control addTarget:self action:@selector(controlSelected:) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:control];
        originX += (controlWidth + self.controlSpacing);
    }
}

#pragma mark - action

- (void)controlSelected:(UIButton *)button
{
    NSUInteger index = button.tag - pageControlTag;
    self.currentPage = index;
    if (self.controlSelect) {
        self.controlSelect(self, index);
    }
}

- (void)changeSelectdWithIndex:(NSUInteger)index
{
    NSUInteger originIndex = self.currentPage;
    UIButton *originBtn = [self viewWithTag:pageControlTag + originIndex];
    UIButton *otherBtn = [self viewWithTag:pageControlTag + index];
    originBtn.backgroundColor = self.controlColor;
    otherBtn.backgroundColor = self.controlSelectedColor;
    [UIView animateWithDuration:self.animationTime animations:^{
        for (NSUInteger i = MIN(originIndex, index); i <= MAX(originIndex, index); i++) {
            CGFloat addX = 0.f;
            if (i == MIN(originIndex, index)) {
                addX = 0.f;
            } else if (originIndex < index) {
                addX = self.controlSize - self.controlSelectedSize;
            } else {
                addX = self.controlSelectedSize - self.controlSize;
            }
            CGFloat width = self.controlSize;
            if (i == index) {
                width = self.controlSelectedSize;
            }
            UIButton *btn = [self viewWithTag:i + pageControlTag];
            CGRect frame = btn.frame;
            frame.origin.x += addX;
            frame.size.width = width;
            btn.frame = frame;
        }
    }];
}

#pragma mark - setter

- (void)setPageNumber:(NSUInteger)pageNumber
{
    if (_pageNumber != pageNumber) {
        _pageNumber = pageNumber;
        [self initView];
    }
}

- (void)setControlSize:(CGFloat)controlSize
{
    if (!doubleEqual(_controlSize, controlSize)) {
        _controlSize = controlSize;
        [self initView];
    }
}

- (void)setControlSelectedSize:(CGFloat)controlSelectedSize
{
    if (!doubleEqual(_controlSelectedSize, controlSelectedSize)) {
        _controlSelectedSize = controlSelectedSize;
        [self initView];
    }
}

- (void)setControlSpacing:(CGFloat)controlSpacing
{
    if (!doubleEqual(_controlSpacing, controlSpacing)) {
        _controlSpacing = controlSpacing;
        [self initView];
    }
}

- (void)setControlColor:(UIColor *)controlColor
{
    if (!color_equal(_controlColor, controlColor)) {
        _controlColor = controlColor;
        [self initView];
    }
}

- (void)setControlSelectedColor:(UIColor *)controlSelectedColor
{
    if (!color_equal(_controlSelectedColor, controlSelectedColor)) {
        _controlSelectedColor = controlSelectedColor;
        [self initView];
    }
}

- (void)setCurrentPage:(NSUInteger)currentPage
{
    if (_currentPage != currentPage) {
        [self changeSelectdWithIndex:currentPage];
        _currentPage = currentPage;
    }
}

#pragma mark - private

- (void)clearAllView
{
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
}

bool color_equal(UIColor *origin, UIColor *other) {
    return CGColorEqualToColor(origin.CGColor, other.CGColor);
}


@end
