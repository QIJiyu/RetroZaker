//
//  EditDataViewController.h
//  RetroZaker
//
//  Created by 祁继宇 on 16/4/13.
//  Copyright © 2016年 Qi Jy/Hu Yr. All rights reserved.
//

#import "ZakerBaseTableViewController.h"

@interface EditDataViewController : ZakerBaseTableViewController

// 上个页面传过来的用户头像
@property (nonatomic, strong) UIImage *iconImage;
// 上个页面传过来的用户名称
@property (nonatomic, strong) NSString *userName;

@end
