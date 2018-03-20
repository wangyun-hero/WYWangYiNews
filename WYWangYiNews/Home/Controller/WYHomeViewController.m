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
static NSString *cellID = @"cellID";
@interface WYHomeViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong) NSMutableArray *dataArray;
@property(nonatomic,strong) WYChannelView *channelView;
@property(nonatomic,strong) UICollectionView *collectionView;
@end

@implementation WYHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    [self setupUI];
    
    
    // Do any additional setup after loading the view.
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
    return cell;
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
