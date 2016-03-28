//
//  QJYButton.m
//  RetroZaker
//
//  Created by 祁继宇 on 16/3/28.
//  Copyright © 2016年 Qi Jy/Hu Yr. All rights reserved.
//

#import "ZakerButton.h"

@implementation ZakerButton

+ (ZakerButton *)addRect:(CGRect)frame Title:(NSString *)title andBlock:(myBlock)block {
    ZakerButton *button = [[ZakerButton alloc] initWithFrame:frame];
    button.backgroundColor = [UIColor whiteColor];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [button setTitleColor:DEFAULT_COLOR forState:UIControlStateSelected];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
//    [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [button addTarget:button action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];

    button.tempBlock = block;
    return button;
}

- (void)buttonClicked:(ZakerButton *)button {
    button.tempBlock(button);
}

@end
