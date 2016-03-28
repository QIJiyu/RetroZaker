//
//  ZakerBaseTableViewController.h
//  RetroZaker
//
//  Created by 祁继宇 on 16/3/28.
//  Copyright © 2016年 Qi Jy/Hu Yr. All rights reserved.
//

#import "ZakerBaseViewController.h"

@interface ZakerBaseTableViewController : ZakerBaseViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView    *myTableView;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end
