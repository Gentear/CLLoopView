# CLLoopView
一个自动循环滚动视图

使用方法

导入头文件


#import "CLLoopView.h"

 //必须这个方法初始化
 
  CLLoopView *loop = [[CLLoopView alloc]initWithFrame:CGRectMake(0, 0, 375, 300)];
  
  loop.imageArray = @[@"123",@"bg",@"bg2",@"bg3"];
  
  loop.delegate = self;
  
  [self.view addSubview:loop];


代理方法如下

- (void)tapClickWithInterger:(NSInteger)index{
- 
    NSLog(@"%ld",index);
    

}
