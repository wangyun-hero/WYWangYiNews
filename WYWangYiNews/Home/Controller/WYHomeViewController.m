//
//  WYHomeViewController.m
//  WYWangYiNews
//
//  Created by 王云 on 2018/3/20.
//  Copyright © 2018年 王云. All rights reserved.
//

#import "WYHomeViewController.h"
#import "WYHomeLabelModel.h"
#import "WYChannelView.h"
#import <Masonry.h>
#import "UIColor+Addition.h"
#import "WYHomeNewsListController.h"
static NSString *cellID = @"cellID";
@interface WYHomeViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong) NSMutableArray *dataArray;
@property(nonatomic,strong) WYChannelView *channelView;
@property(nonatomic,strong) UICollectionView *collectionView;
// 防止重复创建控制器，重复添加view
@property(nonatomic,strong) NSMutableDictionary *dict;
@end

@implementation WYHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    [self setupUI];
    
    
    // Do any additional setup after loading the view.
}

-(NSMutableDictionary *)dict
{
    if (!_dict) {
        _dict = [NSMutableDictionary new];
    }
    return _dict;
}

-(void)setupUI
{
    WYChannelView *channelView = [WYChannelView channelView];
    [self.view addSubview:channelView];
    self.channelView = channelView;
    channelView.channelArray = self.dataArray;
//    self.channelView.frame = CGRectMake(0, 100, self.view.bounds.size.width, 40);
    [self.channelView  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.mas_topLayoutGuideBottom);
        make.height.offset(40);
    }];
    
    [self setupCollectionView];
    
    
}

-(void)setupCollectionView
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
   
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView = collectionView;
    collectionView.showsVerticalScrollIndicator = false;
    collectionView.showsHorizontalScrollIndicator= false;
    collectionView.pagingEnabled = YES;
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:cellID];
    [self.view addSubview:collectionView];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.channelView.mas_bottom);
        make.bottom.equalTo(self.view);
        
    }];
    
}

-(void)loadData
{
    NSLog(@"测试git提交");
    NSArray *array = @[@"新闻",@"军事",@"人文",@"科技",@"农业",@"天文",@"篮球",@"足球",@"乒乓球",@"橄榄球",@"棒球",@"地球",@"月球",@"水球",@"德玛西亚"];
    for (int i = 0; i < 15; i++) {
        WYHomeLabelModel *model = [[WYHomeLabelModel alloc] init];
        model.title = [array objectAtIndex:i];
        [self.dataArray addObject:model];
        
    }
    
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    NSLog(@"%@",NSStringFromCGPoint(scrollView.contentOffset));
    
    // 第几页
    CGFloat ratio = scrollView.contentOffset.x / scrollView.frame.size.width;
//    NSLog(@"%f",ratio);
    // 从右往左滑当前页面的索引
    NSInteger index = ratio / 1;

    // 缩放的比例
    CGFloat scale = ratio - index;
    NSLog(@"之前显示的%zd，即将显示的%zd，比例%f",index,index+1,scale);
    // 设置下一个页面的缩放
    [self.channelView setScale:scale withIndex:index+1];
    // 设置当前页面的缩放
    [self.channelView setScale:1-scale withIndex:index];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;

}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor randomColor];
    // 解决content里面view没有移除，重复叠加的问题
    // 方法一
//    for (UIView *view  in cell.contentView.subviews) {
//        [view removeFromSuperview];
//    }
    
    // 方法二
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    
    // 添加子控制器
    WYHomeLabelModel *model = [self.dataArray objectAtIndex:indexPath.row];
    // 避免重复创建
    UIViewController *vc = [self viewControllerWithModel:model];
    
//    WYHomeNewsListController *vc = [[WYHomeNewsListController alloc]init];
    // 添加view
    [cell.contentView addSubview:vc.view];
    //    约束
    [vc.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(cell.contentView);
    }];
    [self addChildViewController:vc];
    
    return cell;
}

// 从缓存中取控制器
-(UIViewController *)viewControllerWithModel:(WYHomeLabelModel *)model
{
    UIViewController *vc = [self.dict objectForKey:model.title];
    if (vc == nil) {
        vc = [[WYHomeNewsListController alloc]init];
        [self.dict setObject:vc forKey:model.title];
    }
    return vc;
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    layout.itemSize = self.collectionView.bounds.size;
}

-(NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
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
