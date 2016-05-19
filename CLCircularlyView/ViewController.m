//
//  ViewController.m
//  CLCircularlyView
//
//  Created by zyyt on 16/1/14.
//  Copyright © 2016年 zyyt. All rights reserved.
//

#import "ViewController.h"
#import "CLLoopView.h"
@interface ViewController ()<UITableViewDataSource,UITableViewDelegate,CLLoopViewDelegate>
@property (weak,nonatomic) UITableView *tableView;
@property (weak,nonatomic) CLLoopView *loop;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self tableView];
}
#pragma mark - 懒加载
- (UITableView *)tableView{
    if (_tableView == nil) {
        
        UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource = self;
        [self.view addSubview:tableView];
        tableView.tableHeaderView = self.loop;
        _tableView = tableView;
    }
    return _tableView;
}
- (CLLoopView *)loop{
    if (_loop == nil) {
        
        CLLoopView *loop = [[CLLoopView alloc]initWithFrame:CGRectMake(0, 0, 375, 300)];
        loop.imageArray = @[@"123",@"bg",@"bg2",@"bg3"];
        loop.delegate = self;
        [self.view addSubview:loop];
        _loop = loop;
    }
    return _loop;
}
#pragma mark - UITableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        
    }
    
    cell.textLabel.text = @"123";
    
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 40;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)tapClickWithInterger:(NSInteger)index{
    NSLog(@"%ld",index);
}
@end
