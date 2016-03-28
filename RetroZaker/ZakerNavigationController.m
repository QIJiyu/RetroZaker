//
//  ZakerNavigationController.m
//  RetroZaker
//
//  Created by 祁继宇 on 16/3/28.
//  Copyright © 2016年 Qi Jy/Hu Yr. All rights reserved.
//

#import "ZakerNavigationController.h"

@interface ZakerNavigationController ()

@end

@implementation ZakerNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationBar.barTintColor = RGBCOLOR(227, 68, 66);
    self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor],  NSFontAttributeName:[UIFont systemFontOfSize:16]};
    self.navigationBar.tintColor = [UIColor whiteColor];
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
