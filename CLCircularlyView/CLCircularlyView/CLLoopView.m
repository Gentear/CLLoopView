//
//  CLLoopView.m
//  CLCircularlyView
//
//  Created by zyyt on 16/5/18.
//  Copyright © 2016年 zyyt. All rights reserved.
//
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define ScreenBounds [UIScreen mainScreen].bounds
#define selfWidth  self.frame.size.width
#define selfHeight self.frame.size.height
#import "CLLoopView.h"
#import "CLLoopCell.h"
@interface CLLoopView ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (weak,nonatomic) UICollectionView *collectionView;
@property (nonatomic,strong)NSTimer * timer;
@end

@implementation CLLoopView
#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.delegate respondsToSelector:@selector(tapClickWithInterger:)]) {
        [self.delegate tapClickWithInterger:indexPath.row];
    }
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.imageArray.count;
}
//创建cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CLLoopCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CLLoopCell" forIndexPath:indexPath];
    cell.cellImage.image = [UIImage imageNamed:self.imageArray[indexPath.row]];
    return cell;
}
#pragma mark - 懒加载
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
- (UICollectionView *)collectionView{
    if (_collectionView == nil) {
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        flowLayout.minimumLineSpacing = 0;
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.itemSize = self.frame.size;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:flowLayout];
        collectionView.backgroundColor = [UIColor whiteColor];
        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView.pagingEnabled = YES;
        [collectionView registerClass:[CLLoopCell class] forCellWithReuseIdentifier:@"CLLoopCell"];
        [self addSubview:collectionView];
        
        _collectionView = collectionView;
    }
    return _collectionView;
}
- (void)setImageArray:(NSArray *)imageArray{
    NSMutableArray *imageData = [NSMutableArray new];
    [imageData addObject:imageArray[imageArray.count-1]];
    for (NSString * imageName  in imageArray) {
        [imageData addObject:imageName];
    }
    [imageData addObject:imageArray[0]];
    
    _imageArray = imageData;
    [self.collectionView reloadData];
    [self.collectionView setContentOffset:CGPointMake(selfWidth,0) animated:NO];
    self.pageControl.numberOfPages = imageArray.count;
    [self startTimer];
}
- (void)setIsAuto:(BOOL)isAuto{
    if (isAuto == YES) {
        [self startTimer];
    }else{
        [self stopTimer];
    }
}
- (void)setInterval:(NSInteger)interval{
    _interval = interval;
}
- (NSTimer *)timer{
    if (_timer == nil) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(runTimePage) userInfo:nil repeats:true];
    }
    return _timer;
}
#pragma mark - 定时器方法
/**
 *  timer
 */
- (void)startTimer
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self timer];
        [[NSRunLoop currentRunLoop] run];
        
    });
}
-(void)stopTimer
{
    [self.timer invalidate];
    self.timer = nil;
}
/**
 *  自动滚动
 */
-(void)runTimePage
{
    int currentPage = (int) self.collectionView.contentOffset.x/selfWidth;
    
    if (currentPage != self.imageArray.count - 1) {
        
        if (currentPage == self.imageArray.count-2) {
            self.pageControl.currentPage = 0;
            
        }else{
            self.pageControl.currentPage = currentPage;
        }
        [self.collectionView setContentOffset:CGPointMake(selfWidth*(currentPage+1),0) animated:YES];
    }
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
    
    int currentPage = (int) self.collectionView.contentOffset.x/selfWidth;
    if (currentPage==0)
    {
        [self.collectionView setContentOffset:CGPointMake(selfWidth * ([self.imageArray count]-2),0) animated:NO];
        self.pageControl.currentPage = self.imageArray.count - 3;
        
    }
    else if (currentPage==[self.imageArray count]-1)
    {
        [self.collectionView setContentOffset:CGPointMake(selfWidth,0) animated:NO];
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
    int currentPage = (int) self.collectionView.contentOffset.x/selfWidth;
    if (currentPage == self.imageArray.count - 1) {
        [self.collectionView setContentOffset:CGPointMake(selfWidth,0) animated:NO];
    }
}
- (void)dealloc{
    _collectionView.delegate = nil;
    _collectionView.dataSource = nil;
    _timer = nil;
}
@end
