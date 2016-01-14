# CLCircularlyView
一个自动循环滚动视图
使用方法

导入头文件


#import "CLCircularlyView.h"

 //必须这个方法初始化
 
 
    CLCircularlyView *cl = [[CLCircularlyView alloc]initWithFrame:CGRectMake(0, 0, 375, 300)];
    
    cl.imageArray = @[@"123",@"bg",@"bg2",@"bg3"];
    
    [self.view addSubview:cl];
