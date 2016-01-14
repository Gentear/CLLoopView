//
//  CLAutoScroll.m
//  coloradd
//
//  Created by zyyt on 15/12/9.
//  Copyright © 2015年 zyyt. All rights reserved.
//
#define selfWidth  self.frame.size.width
#define selfHeight self.frame.size.height
#import "CLCircularlyView.h"

@interface CLCircularlyView()<UIScrollViewDelegate>
@property (weak,nonatomic)UIScrollView *scrollView;
@property (strong,nonatomic)NSMutableArray * imageData;
@property (nonatomic,strong)NSTimer * timer;
@property (nonatomic,assign)int count;
@property (nonatomic,strong)UIView *mySuperView;
@end

@implementation CLCircularlyView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        // Initialization code
        //初始化
        _count = 1;
    }
    
    return self;
}

#pragma mark - view搭建
/**
 *  设置照片
 *
 *  @param imageArray <#imageArray description#>
 */
- (void)setImageArray:(NSArray *)imageArray{
    _imageArray = imageArray;
    //给照片数组添加头尾照片
    [self.imageData addObject:self.imageArray[self.imageArray.count-1]];
    for (NSString * imageName  in self.imageArray) {
        [self.imageData addObject:imageName];
    }
    [self.imageData addObject:self.imageArray[0]];
    
    
    
    //    将图片添加到scrollView
    float x = 0 ;
    for (NSString * imageName in self.imageData) {
        UIImageView * image = [[UIImageView alloc]initWithFrame:CGRectMake(x, 0, selfWidth , selfHeight)];
        image.image = [UIImage imageNamed:imageName];
        [self.scrollView addSubview:image];
        x += self.selfWidth;
        image.userInteractionEnabled = YES;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewTouch:)];
        [image addGestureRecognizer:tap];
        image.tag = x/selfWidth;
    }
    
    
    self.scrollView.contentSize = CGSizeMake(selfWidth*self.imageData.count, 0);
    [self.scrollView setContentOffset:CGPointMake(selfWidth,0) animated:NO];
    self.pageControl.numberOfPages = self.imageArray.count;
    [self startTimer];
}
/**
 *  点击照片的代理方法
 *
 *  @param tap <#tap description#>
 */
- (void)imageViewTouch:(UITapGestureRecognizer *)tap
{
    NSInteger index = tap.view.tag;
    if ([self.delegates respondsToSelector:@selector(tapClickWithInterger:)]) {
        
        [self.delegates tapClickWithInterger:index];
        
    }
}
#pragma mark - 懒加载
/**
 *  imageData是将头尾照片加入后的照片数组
 *
 *  @return
 */
- (NSMutableArray *)imageData{
    if (_imageData == nil) {
        
        _imageData = [NSMutableArray array];
        
    }
    return _imageData;
}
/**
 *  懒加载pageControll
 */
- (UIPageControl *)pageControl{
    if (_pageControl ==nil) {
        UIPageControl *pageControl = [[UIPageControl alloc]init];
        pageControl.frame = CGRectMake(0, 0, 100, 20);
        pageControl.center = CGPointMake(selfWidth/2,selfHeight - 30);
        pageControl.currentPageIndicatorTintColor = [UIColor redColor];
        [self addSubview:pageControl];
        _pageControl = pageControl;
        
    }
    return _pageControl;
}
/**
 *  懒加载scrollview
 */
- (UIScrollView *)scrollView{
    if (_scrollView == nil) {
        
        UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:self.bounds];
        [self addSubview:scrollView];
        scrollView.delegate = self;
        scrollView.pagingEnabled = YES;
        _scrollView = scrollView;
    }
    return _scrollView;
}
#pragma mark - 定时器方法
/**
 *  timer
 */
- (void)startTimer
{
    self.timer =  [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(runTimePage) userInfo:nil repeats:YES];
    
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}
-(void)stopTimer
{
    [self.timer invalidate];
    self.timer = nil;
}
#pragma mark - UIScrollViewDelegate
/**
 *  当手滑动时停止滚动
 *
 *  @param scrollView <#scrollView description#>
 */
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self stopTimer];
}
/**
 *  松手继续滚动
 *
 *  @param scrollView <#scrollView description#>
 *  @param decelerate <#decelerate description#>
 */
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self startTimer];
}
/**
 *  手动滑动
 *
 *  @param scrollView <#scrollView description#>
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    int currentPage = (int) self.scrollView.contentOffset.x/selfWidth;
    if (currentPage==0)
    {
        [self.scrollView setContentOffset:CGPointMake(selfWidth * ([self.imageData count]-2),0) animated:NO];
        self.pageControl.currentPage = self.imageArray.count - 1;
        
    }
    else if (currentPage==[self.imageData count]-1)
    {
        [self.scrollView setContentOffset:CGPointMake(selfWidth,0) animated:NO];
        self.pageControl.currentPage = 0;
        
    }else{
        self.pageControl.currentPage = currentPage-1;
    }
    
}
/**
 *  滚动动画执行完成后的代理方法
 *
 *  @param scrollView <#scrollView description#>
 */
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    int currentPage = (int) self.scrollView.contentOffset.x/selfWidth;
    if (currentPage == self.imageArray.count + 1) {
        [self.scrollView setContentOffset:CGPointMake(selfWidth,0) animated:NO];
    }
}
#pragma mark - 自动滑动
/**
 *  自动滑动
 */
-(void)runTimePage
{
    
    int currentPage = (int) self.scrollView.contentOffset.x/selfWidth;
    
    if (currentPage != self.imageArray.count + 1) {
        
        if (currentPage == self.imageArray.count) {
            self.pageControl.currentPage = 0;
            
        }else{
            self.pageControl.currentPage = currentPage;
        }
        [self.scrollView setContentOffset:CGPointMake(selfWidth*(currentPage+1),0) animated:YES];
    }
    
}

@end
