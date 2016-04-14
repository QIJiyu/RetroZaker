//
//  ZakerSubscribeViewController.m
//  RetroZaker
//
//  Created by 祁继宇 on 16/3/28.
//  Copyright © 2016年 Qi Jy/Hu Yr. All rights reserved.
//

#import "ZakerSubscribeViewController.h"

@interface ZakerSubscribeViewController ()

@property (nonatomic, strong) UICollectionView           *myCollectionView;
@property (nonatomic, strong) NSMutableArray             *collectionViewDataSource;
@property (nonatomic, strong) UICollectionViewFlowLayout *collectionViewLayout;
@property (nonatomic, strong) UIImageView                *dropCoverImageView;

@end

@implementation ZakerSubscribeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _collectionViewDataSource = [NSMutableArray arrayWithObject:@[@"1", @"1", @"1", @"1", @"1", @"1", @"1"]];
    [self createCollectionView];
    // 集成刷新控件
    [self setupRefresh];
    
    [self createDropCover];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self createMyControl];
}

/**
 *  集成下拉刷新
 */
-(void)setupRefresh
{
    //1.添加刷新控件
    UIRefreshControl *control=[[UIRefreshControl alloc]init];
    [control addTarget:self action:@selector(refreshStateChange:) forControlEvents:UIControlEventValueChanged];
    [_myCollectionView addSubview:control];
    
    //2.马上进入刷新状态，并不会触发UIControlEventValueChanged事件
    [control beginRefreshing];
    
    // 3.加载数据
    [self refreshStateChange:control];
}

/**
 *  UIRefreshControl进入刷新状态
 */
-(void)refreshStateChange:(UIRefreshControl *)control
{
    // 3. 结束刷新
    [control endRefreshing];
}

- (void)createCollectionView {
    _collectionViewLayout = [[UICollectionViewFlowLayout alloc] init];
    _myCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KSCREEN_HEIGHT) collectionViewLayout:_collectionViewLayout];
    [self.view addSubview:_myCollectionView]; 
    _myCollectionView.delegate = self;
    _myCollectionView.dataSource = self;
    _myCollectionView.backgroundColor = RGBCOLOR(255, 255, 255);
//    [self.myCollectionView registerNib:[UINib nibWithNibName:@"ZakerSubscribeCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"aCell"];
    [self.myCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"aCell"];
}

#pragma mark - UICollectionViewDataSource
//- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
//    return _dataSource.count;
//}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _collectionViewDataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"aCell" forIndexPath:indexPath];
    return cell;
}

#pragma mark UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:NO];
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake((KSCREEN_WIDTH - 30) / 3, (KSCREEN_WIDTH - 30) / 3);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    //元素之间最小间距
    return 0;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    //设置item边距
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(KSCREEN_WIDTH, 25);
}

-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

#pragma mark 创建下拉封面
- (void)createDropCover {
    NSString *urlString = @"http://c.hiphotos.bdimg.com/imgad/pic/item/908fa0ec08fa513d94b921c23a6d55fbb2fbd99f.jpg";
    _dropCoverImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, -KSCREEN_HEIGHT, KSCREEN_WIDTH, KSCREEN_HEIGHT)];
    [_dropCoverImageView sd_setImageWithURL:[NSURL URLWithString:urlString]];
    
    NSArray *windows = [UIApplication sharedApplication].windows;
    UIWindow *window = [windows objectAtIndex:0];
    if(window.subviews.count > 0){
        [window addSubview:_dropCoverImageView];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat y = scrollView.contentOffset.y;
    ZAKER_Log(@"%f", y);
}

#pragma mark Control
- (void)createMyControl {
    self.navigationItem.title = @"订阅";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(search)];
}

- (void)search {
    
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
