//
//  ZakerLine.m
//  RetroZaker
//
//  Created by 祁继宇 on 16/3/28.
//  Copyright © 2016年 Qi Jy/Hu Yr. All rights reserved.
//

#import "ZakerLine.h"

@implementation ZakerLine

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(context, 0, self.frame.size.height / 2);
    CGContextAddLineToPoint(context, self.frame.size.width, self.frame.size.height / 2);
    
    CGContextSetLineWidth(context, 2);
    CGContextSetRGBStrokeColor(context, 227/225, 68/225, 66/225, 1);
    
    CGContextStrokePath(context);
}


@end
