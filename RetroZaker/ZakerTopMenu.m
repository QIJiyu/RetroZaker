//
//  ZakerTopMenu.m
//  RetroZaker
//
//  Created by 祁继宇 on 16/3/28.
//  Copyright © 2016年 Qi Jy/Hu Yr. All rights reserved.
//

#import "ZakerTopMenu.h"
#import "ZakerButton.h"

@implementation ZakerTopMenu

- (id)initWithFrame:(CGRect)frame menuTitleArray:(NSArray *)menuTitleArray {
    if (self = [super init]) {
        self.frame = frame;
        self.backgroundColor = [UIColor whiteColor];
        _menuTitleArray = [menuTitleArray copy];
        [self createButton];
    }
    return self;
}

- (void)createButton {
    for (NSInteger index = 0; index < _menuTitleArray.count; index++) {
        CGFloat btnWidth = KSCREEN_WIDTH / _menuTitleArray.count;
        __block ZakerButton *btn = [ZakerButton addRect:CGRectMake(btnWidth * index, 0, btnWidth, self.frame.size.height - 1) Title:_menuTitleArray[index] andBlock:^(ZakerButton *button) {
            
            for (UIView *view in self.subviews) {
                if ([view isKindOfClass:[ZakerButton class]]) {
                    if (view == btn) {
                        btn.selected = YES;
                    }else if (view != btn){
                        btn.selected = NO;
                    }
                }
            }
            
            [UIView animateWithDuration:0.3 animations:^{
                CGRect newLineFrame = CGRectMake(btn.frame.origin.x, self.frame.size.height - 2, btnWidth, 2);
                _selectLine.frame = newLineFrame;
            }];
        }];
        btn.tag = 100 + index;
        [self addSubview:btn];
        if (btn.tag == 100) {
            btn.selected = YES;
            _selectLine = [[ZakerLine alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 2, btnWidth, 2)];
            _selectLine.userInteractionEnabled = YES;
            [btn addSubview:_selectLine];
        }
    }
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(context, 0, self.frame.size.height);
    CGContextAddLineToPoint(context, self.frame.size.width, self.frame.size.height);
    
    CGContextSetLineWidth(context, 1);
    CGContextSetRGBStrokeColor(context, 184/225, 188/225, 194/225, 1);

    CGContextStrokePath(context);
};

@end
