//
//  ZakerTabBarController.m
//  RetroZaker
//
//  Created by 祁继宇 on 16/3/28.
//  Copyright © 2016年 Qi Jy/Hu Yr. All rights reserved.
//

#import "ZakerTabBarController.h"
#import "ZakerNavigationController.h"

@interface ZakerTabBarController ()

@end

@implementation ZakerTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //定制TabBar
    [self makeTabBar];
    //添加子视图
    [self addSubViewControllers];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //定制TabBarItems
    [self makeTabBarItems];
}

#pragma mark - TabBar
- (void)makeTabBar {
    //    [self.tabBar setBackgroundImage:[UIImage:@""]];
    //    self.tabBar.backgroundColor = RGBCOLOR(37, 37, 45);
    self.tabBar.barTintColor = RGBCOLOR(240, 240, 240);
    self.tabBar.tintColor = RGBCOLOR(232, 75, 76);
}

#pragma mark - ViewControllers
- (void)addSubViewControllers {
    NSArray *names = @[@"ZakerSubscribeViewController", @"ZakerHotViewController", @"ZakerFunViewController", @"ZakerCommunityViewController"];
    
    NSMutableArray *viewControllers = [[NSMutableArray alloc] init];
    
    for (NSString *name in names) {
        Class class = NSClassFromString(name);
        UIViewController *vc = [[class alloc] init];

        ZakerNavigationController *nav = [[ZakerNavigationController alloc] initWithRootViewController:vc];
        [viewControllers addObject:nav];
    }
    self.viewControllers = viewControllers;
}

#pragma mark - TabBarItems
- (void)makeTabBarItems {
    NSArray *viewControllers = self.viewControllers;
    NSArray *imageNames = @[@"", @"", @"", @""];
    NSArray *selectedImageNames = @[@"", @"", @"", @""];
    NSArray *titles = @[@"订阅", @"玩乐", @"热点", @"社区"];
    //遍历所有子元素，定制各自的TabBarItem
    for (int i = 0; i < viewControllers.count; i++) {
        UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:titles[i] image:[UIImage imageNamed:imageNames[i]] selectedImage:[UIImage imageNamed:selectedImageNames[i]]];
        [viewControllers[i] setTabBarItem:item];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
