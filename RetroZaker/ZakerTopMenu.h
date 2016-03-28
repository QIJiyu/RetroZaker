//
//  ZakerTopMenu.h
//  RetroZaker
//
//  Created by 祁继宇 on 16/3/28.
//  Copyright © 2016年 Qi Jy/Hu Yr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZakerLine.h"

@interface ZakerTopMenu : UIView

@property (nonatomic, strong) NSArray *menuTitleArray;
@property (nonatomic, strong) ZakerLine *selectLine;

- (id)initWithFrame:(CGRect)frame menuTitleArray:(NSArray *)menuTitleArray;

@end
