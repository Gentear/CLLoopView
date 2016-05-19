//
//  CLLoopView.h
//  CLCircularlyView
//
//  Created by zyyt on 16/5/18.
//  Copyright © 2016年 zyyt. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CLLoopView;
@protocol CLLoopViewDelegate <NSObject>
/**
 *  点击图片执行的
 *
 *  @param index 图片的tag值
 */
- (void)tapClickWithInterger:(NSInteger)index;
@end
@interface CLLoopView : UIView
/**
 *  代理
 */
@property (weak,nonatomic)id<CLLoopViewDelegate>delegate;
/**
 *  照片数组
 */
@property (strong,nonatomic) NSArray *imageArray;
/**
 *  pageControl
 */
@property (strong, nonatomic) UIPageControl *pageControl;
/**
 *  title
 */
@property (strong,nonatomic) NSArray *titleArray;
/**
 *  是否自动滚动
 */
@property (assign,nonatomic) BOOL isAuto;
/**
 *  滚动时间间隔
 */
@property (assign,nonatomic) NSInteger interval;
@end
