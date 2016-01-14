//
//  ViewController.m
//  CLCircularlyView
//
//  Created by zyyt on 16/1/14.
//  Copyright © 2016年 zyyt. All rights reserved.
//

#import "ViewController.h"
#import "CLCircularlyView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //必须这个方法初始化
    CLCircularlyView *cl = [[CLCircularlyView alloc]initWithFrame:CGRectMake(0, 0, 375, 300)];
    //    cl.frame = CGRectMake(0, 0, 375, 300);
    cl.imageArray = @[@"123",@"bg",@"bg2",@"bg3"];
    
    [self.view addSubview:cl];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
