//
//  CLAutoScroll.h
//  coloradd
//
//  Created by zyyt on 15/12/9.
//  Copyright © 2015年 zyyt. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CLCircularlyView;
@protocol CLCircularlyViewDelegate <NSObject>
/**
 *  点击图片执行的
 *
 *  @param index 图片的tag值
 */
- (void)tapClickWithInterger:(NSInteger)index;
@end
@interface CLCircularlyView : UIView
/**
 *  代理
 */
@property (weak,nonatomic)id<CLCircularlyViewDelegate>delegates;
/**
 *  照片数组
 */
@property (strong,nonatomic) NSArray *imageArray;
/**
 *  pageControl
 */
@property (strong, nonatomic) UIPageControl *pageControl;
@end
