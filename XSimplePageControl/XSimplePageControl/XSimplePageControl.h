//
//  XSimplePageControl.h
//  XSimplePageControl
//
//  Created by LiX i n long on 2018/1/23.
//  Copyright © 2018年 LiX i n long. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XSimplePageControl : UIView

/**< 页数*/
@property (nonatomic) NSUInteger pageNumber;
/**< 当前页*/
@property (nonatomic) NSUInteger currentPage;
/**< 按钮大小*/
@property (nonatomic) CGFloat controlSize;
/**< 选择按钮宽度度*/
@property (nonatomic) CGFloat controlSelectedSize;
/**< 空隙宽度*/
@property (nonatomic) CGFloat controlSpacing;
/**< 动画时长*/
@property (nonatomic) CGFloat animationTime;
/**< 按钮颜色*/
@property (nonatomic, strong) UIColor *controlColor;
/**< 选中颜色*/
@property (nonatomic, strong) UIColor *controlSelectedColor;
/**< 点击按钮回调*/
@property (nonatomic, copy) void(^controlSelect)(XSimplePageControl *pageControl, NSUInteger index);

@end
