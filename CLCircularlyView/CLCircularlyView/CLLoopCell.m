//
//  CLLoopCell.m
//  CLCircularlyView
//
//  Created by zyyt on 16/5/19.
//  Copyright © 2016年 zyyt. All rights reserved.
//

#import "CLLoopCell.h"

@implementation CLLoopCell
- (UIImageView *)cellImage{
    if (_cellImage == nil) {
        
        UIImageView *cellImage = [[UIImageView alloc]initWithFrame:self.bounds];
        [self addSubview:cellImage];
        _cellImage = cellImage;
    }
    return _cellImage;
}
@end
