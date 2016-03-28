//
//  ZakerBaseViewController.m
//  RetroZaker
//
//  Created by 祁继宇 on 16/3/28.
//  Copyright © 2016年 Qi Jy/Hu Yr. All rights reserved.
//

#import "ZakerBaseViewController.h"

@interface ZakerBaseViewController ()

@end

@implementation ZakerBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view. 

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self createControl];
}

- (void)createControl {
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_mine_normal"] style:UIBarButtonItemStylePlain target:self action:@selector(PersonalInformation)];
}

- (void)PersonalInformation {
    
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
