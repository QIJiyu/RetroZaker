//
//  MyInformationViewController.m
//  RetroZaker
//
//  Created by 祁继宇 on 16/4/12.
//  Copyright © 2016年 Qi Jy/Hu Yr. All rights reserved.
//

#import "MyInformationViewController.h"
#import "EditDataViewController.h"

#define HEADER_HEIGHT 100

@interface MyInformationViewController ()

@property (nonatomic, strong) UIImageView *headerView;
// 用户头像
@property (nonatomic, strong) UIImageView *iconImageView;
// 用户昵称
@property (nonatomic, strong) UILabel *nicknameLabel;

@end

@implementation MyInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataSource = [NSMutableArray arrayWithObjects:@[@"好友分享", @"消息中心", @"我的玩乐", @"推送资讯", @"积分活动", @"我的收藏", @"二维码"]
                                                        , @[@"离线阅读", @"清理缓存", @"夜间模式", @"更多设置"]
                                                        , @[@"意见反馈", @"关于 ZAKER v6.5.1"], nil];
    [self createMyTableView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)createControl {
    self.navigationItem.title = @"我的";
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];
    self.navigationItem.rightBarButtonItem = nil;
}

- (void)createMyTableView {
    //头视图
    _headerView = [[UIImageView alloc] initWithFrame:CGRectMake(0, -HEADER_HEIGHT, KSCREEN_WIDTH, HEADER_HEIGHT)];
    _headerView.image = [UIImage imageWithColor:DEFAULT_COLOR];
//    _headerView.image = [UIImage imageNamed:@"aaaa.jpg"];
    _headerView.contentMode = UIViewContentModeScaleAspectFill;
    [self.myTableView insertSubview:_headerView atIndex:0];
    _headerView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(editData:)];
    [_headerView addGestureRecognizer:tapGesture];
    
    //头视图上的元素
    UIImageView *iconImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"vtmServiceHeader"]];
    iconImageView.frame = CGRectMake((KSCREEN_WIDTH - 50) / 2, -HEADER_HEIGHT, 50, 50);
    iconImageView.layer.cornerRadius = 25;
    iconImageView.layer.masksToBounds = YES;
    _iconImageView = iconImageView;
    [self.myTableView addSubview:_iconImageView];
    
    UILabel *nicknameLabel = [[UILabel alloc] initWithFrame:CGRectMake((KSCREEN_WIDTH - 50) / 2, iconImageView.frame.origin.y + 60, 50, 15)];
    nicknameLabel.text = @"I Do";
    nicknameLabel.textAlignment = NSTextAlignmentCenter;
    nicknameLabel.textColor = [UIColor whiteColor];
    nicknameLabel.font = [UIFont systemFontOfSize:12];
    _nicknameLabel = nicknameLabel;
    [self.myTableView addSubview:_nicknameLabel];
    
    self.myTableView.contentInset = UIEdgeInsetsMake(HEADER_HEIGHT, 0, 0, 0);
}

#pragma mark UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = self.dataSource[indexPath.section][indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:13];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger )section {
    return 1.0 ;
}

#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ZAKER_Log(@"选中了%lu组, %lu行", indexPath.section, indexPath.row);
    if (indexPath.section == 0)
    {
        switch (indexPath.row) {
            case 0:
                
                break;
            case 1:
                
                break;
            case 2:
                
                break;
            case 3:
                
                break;
            case 4:
                
                break;
            case 5:
                
                break;
            case 6:
            {
                UIViewController *vc = [NSClassFromString(@"QrCodeViewController") new];
                
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            default:
                break;
        }
    }
    else if (indexPath.section == 1)
    {
        
    }
    else if (indexPath.section == 2)
    {
        
    }
}

#pragma mark UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat y = scrollView.contentOffset.y;
    
    if (y < -HEADER_HEIGHT) {
        CGRect frame = _headerView.frame;
        frame.origin.y = y;
        frame.size.height = -y;
        _headerView.frame = frame;
    }
}

#pragma mark Click
- (void)editData:(UITapGestureRecognizer *)tapGesture {
    EditDataViewController *vc = [[EditDataViewController alloc] init];
    vc.iconImage = _iconImageView.image;
    vc.userName = _nicknameLabel.text;
    [self.navigationController pushViewController:vc animated:YES];
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
