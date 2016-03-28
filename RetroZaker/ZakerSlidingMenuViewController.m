//
//  ZakerSlidingMenuViewController.m
//  RetroZaker
//
//  Created by 祁继宇 on 16/3/28.
//  Copyright © 2016年 Qi Jy/Hu Yr. All rights reserved.
//

#import "ZakerSlidingMenuViewController.h"
#import "ZakerSlidingMenuTableView.h"
#import "ZakerTopMenu.h"

@interface ZakerSlidingMenuViewController ()

@end

@implementation ZakerSlidingMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createTopMenu];
    [self createBackView];
    [self createTableView];
}

- (void)createTopMenu {
    ZakerTopMenu *topMenu = [[ZakerTopMenu alloc] initWithFrame:CGRectMake(0, KSTATUSBAR_HEIGHT + KNAVIGATIONBAR_HEIGHT, KSCREEN_WIDTH, 30) menuTitleArray:@[@"关注", @"精选", @"发现"]];
    [self.view addSubview:topMenu];
}

- (void)createBackView {
    
}

- (void)createTableView {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
