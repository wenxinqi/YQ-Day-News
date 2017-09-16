//
//  YQPictureViewController.m
//  DayNews
//
//  Created by 奇奇 on 2017/7/20.
//  Copyright © 2017年 奇奇. All rights reserved.
//

#import "YQPictureViewController.h"
#import "YQCollectionViewWaterFlowLayout.h"
#import "YQShowPictureController.h"
#import "YQShowItemView.h"
#import "YQPictureData.h"
#import "YQPhotoItem.h"

@interface YQPictureViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic , strong) UICollectionView  *collectionView;

//YQshowItemView
@property (nonatomic , strong) YQShowItemView  *showItemView;

//当前页请求的个数
@property (nonatomic, assign) int pn;
@property (nonatomic , strong) NSString *tag1;
@property (nonatomic , strong) NSString *tag2;
@property (nonatomic , strong) NSMutableArray *pictureArray;

@end

@implementation YQPictureViewController

static NSString * const YQPictureID = @"picture";

- (void)viewDidLoad {
    [super viewDidLoad];

//    创建collectionView
    [self setupCollectionView];
//    创建刷新
    [self setupRefresh];


}

#pragma mark 创建collectionView和导航栏的按钮j

- (void)setupCollectionView
{
    //    默认参数
    self.tag1 = @"宠物";
    self.tag2 = @"全部";

    self.title = @"图片";
    //    添加一个navigation的右标题按钮
    UIBarButtonItem *rightBarItem = [UIBarButtonItem itemWithImageAndTitle:self.tag1 image:@"arrow_up" target:self Selector:@selector(openMenu)];
    
    self.navigationItem.rightBarButtonItem = rightBarItem;
    
    //      自定义一个流水布局
    YQCollectionViewWaterFlowLayout *waterFlowLayout = [[YQCollectionViewWaterFlowLayout alloc] init];
    waterFlowLayout.columnsCount = 3;
    
    waterFlowLayout.HeightBlock = ^CGFloat(CGFloat sender, NSIndexPath *indexPath) {
        YQPictureData *pictureData = self.pictureArray[indexPath.item];
        return  pictureData.small_height /pictureData.small_width * sender;
    };
    
#warning 创建collectionview时必须初始化flowlayout。不然flowlayout会显示为nil
    UICollectionView *collectionV = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:waterFlowLayout];
    collectionV.dataSource = self;
    collectionV.delegate = self;
    collectionV.backgroundColor = [UIColor whiteColor];
    collectionV.showsVerticalScrollIndicator = YES;
    [collectionV registerNib:[UINib nibWithNibName:NSStringFromClass([YQPhotoItem class]) bundle:nil] forCellWithReuseIdentifier:YQPictureID];
    
    [self.view addSubview:collectionV];
    self.collectionView = collectionV;
    
    
}

- (void) setupRefresh
{
    self.collectionView.mj_header = [YQRefreshGifController headerWithRefreshingBlock:^{
        self.pn = 0;
        [self loadData];
    }];
    //    自动调整header的透明度
    self.collectionView.mj_header.automaticallyChangeAlpha = YES;
    
    //    当进入这个界面时就刷新
    [self.collectionView.mj_header beginRefreshing];

    self.collectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self loadData];
    }];
}

- (void)loadData
{
   
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    dic[@"pn"] = [NSString stringWithFormat:@"%d",self.pn];
    dic[@"rn"] = @60;
    
    NSString *urlstr = [NSString stringWithFormat:@"http://image.baidu.com/wisebrowse/data?tag1=%@&tag2=%@",self.tag1,self.tag2];
    
//    urlstr = [urlstr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
#warning   将你的URL的字符进行转义。
    urlstr = [urlstr stringByAddingPercentEncodingWithAllowedCharacters:[NSMutableCharacterSet URLQueryAllowedCharacterSet]];
    
    [[YQRequestTool shareRequestTool] setupRequestWithParameters:dic getPath:urlstr sussce:^(id responseObject) {
        NSArray *dataArray = [YQPictureData mj_objectArrayWithKeyValuesArray:responseObject[@"imgs"]];
       
        NSMutableArray *pictureArray = [[NSMutableArray alloc] init];
        for (YQPictureData *picture in dataArray) {
            [pictureArray addObject:picture];
        }
        
//        当当前上拉刷新，直接显示第一页的数据
        if (self.pn == 0) {
            self.pictureArray = pictureArray;
        }else{ // 如果是下拉刷新，则将数据添加到数组的后面
            [self.pictureArray addObjectsFromArray:pictureArray];
        }
        self.pn += 60;
#warning 数据请求后一定要刷新collectionView
        [self.collectionView reloadData];
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView.mj_footer endRefreshing];
//      当前是第一页的时候隐藏footer
        self.collectionView.mj_footer.hidden = _pictureArray.count < 60;
    } failure:^(id error) {
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView.mj_footer endRefreshing];
    }];
}
//打开菜单
- (void)openMenu
{

    
    if (self.showItemView.isShow) {
        [self.showItemView removeItemView];
       
         self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImageAndTitle:self.tag1 image:@"arrow_up" target:self Selector:@selector(openMenu)];
    }else{
        //    点击btn更新数据
        __weak YQPictureViewController *weak_self = self;
        self.showItemView.selectBtn = ^(NSString *title) {
            weak_self.tag1 = title;
            weak_self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImageAndTitle:weak_self.tag1 image:@"arrow_down" target:weak_self Selector:@selector(openMenu)];
            [weak_self.collectionView.mj_header beginRefreshing];
            [weak_self.showItemView removeItemView];
        };
        
        [self.showItemView addItemView];
    }
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.pictureArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row < self.pictureArray.count) {
        
        YQPhotoItem *cell = [collectionView dequeueReusableCellWithReuseIdentifier:YQPictureID forIndexPath:indexPath];
        cell.pictureData = self.pictureArray[indexPath.item];
        return cell;
    }
//当滚动时移除itemView
    [self.showItemView removeItemView];
    return nil;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
//当点击时移除itemView
    [self.showItemView removeItemView];
    
//    查看大图
    YQShowPictureController *showPictureVc = [[YQShowPictureController alloc] init];
    showPictureVc.pictureData = self.pictureArray[indexPath.item];
    
    [YQApplicationWindow.rootViewController presentViewController:showPictureVc animated:YES completion:nil];
}


#pragma mark lazy
- (YQShowItemView *)showItemView
{
    if (!_showItemView) {
        self.showItemView = [[YQShowItemView alloc] init];
    }
    return _showItemView;
}

- (NSMutableArray *)pictureArray
{
    if (!_pictureArray) {
        self.pictureArray = [[NSMutableArray alloc] init];
    }
    
    return _pictureArray;
}
@end
