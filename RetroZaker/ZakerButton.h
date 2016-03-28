//
//  QJYButton.h
//  RetroZaker
//
//  Created by 祁继宇 on 16/3/28.
//  Copyright © 2016年 Qi Jy/Hu Yr. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZakerButton;

typedef void(^myBlock)(ZakerButton *button);

@interface ZakerButton : UIButton

@property (nonatomic, copy)myBlock tempBlock;

+ (ZakerButton *)addRect:(CGRect)frame Title:(NSString *)title andBlock:(myBlock)block;

@end
