//
//  YQSocialViewController.m
//  DayNews
//
//  Created by 奇奇 on 2017/7/27.
//  Copyright © 2017年 奇奇. All rights reserved.
//

#import "YQSocialViewController.h"
#import "CycleBannerView.h"
#import "YQTopBannerDaTa.h"
#import "YQTotalDaTaModel.h"
#import "YQShowTopBannerController.h"
#import "YQDetailWebController.h"

#import "YQTotalDaTaModel.h"
#import "YQImagesCell.h"
#import "YQNewsCell.h"
#import "YQTopCell.h"
#import "YQBigImageCell.h"

@interface YQSocialViewController()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic , strong) NSMutableArray *totalArray;
@property (nonatomic , strong) CycleBannerView *bannerView;
@property (nonatomic , strong) NSMutableArray *topArray;
@property (nonatomic , strong) NSMutableArray *titleArray;
@property (nonatomic , strong) NSMutableArray *imagesArray;

//当前页
@property (nonatomic, assign) int page;
@end

@implementation YQSocialViewController

/**
 topScrollview:http://c.m.163.com/nc/article/headline/T1348647853363/0-10.html
 NewsCell : http://c.m.163.com/nc/article/headline/T1348647853363/%d-20.html
 */
- (void)viewDidLoad {
    [super viewDidLoad];
//    tableview的基本设置
    [self setupTableView];
    
//    数据刷新
    [self setupRefresh];
}

- (void)setupTableView
{
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self loadTopBannerData];
    
    CycleBannerView *bannerView = [[CycleBannerView alloc] initWithFrame:CGRectMake(0, 64, YQSCREEN_WIDTH, 220)];
    bannerView.bgImg = [UIImage imageNamed:@"shadow.png"];
    
    IMP_BLOCK_SELF(YQSocialViewController);
    bannerView.clickItemBlock = ^(NSInteger index) {
        
        YQTopBannerDaTa *data = block_self.topArray[index];
        NSString *url1 = [data.url substringFromIndex:4];
        url1 = [url1 substringToIndex:4];
        
        NSString *url2 = [data.url substringFromIndex:9];
        
        url2 = [NSString stringWithFormat:@"http://c.3g.163.com/photo/api/set/%@/%@.json",url1,url2];
        YQShowTopBannerController *topVC = [[YQShowTopBannerController alloc]init];
        topVC.url = url2;
        
        [self.navigationController pushViewController:topVC animated:YES];
        
    };
    self.tableView.tableHeaderView = bannerView;
    self.bannerView = bannerView;
}

- (void)setupRefresh
{
    YQRefreshGifController *header = [YQRefreshGifController headerWithRefreshingBlock:^{
        self.page = 0;
        [self requestNet:1];
    }];
    
//    CAAnimation *anim = [[CAAnimation alloc] init];
//    UIImageView *imageV = [[UIImageView alloc] init];
//    imageV.animationImages
    self.tableView.mj_header = header;
    //    自动调整header的透明度
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    
    //   footer
    self.tableView.tableFooterView = [[UIView alloc]init];
    
    //    当进入这个界面时就刷新
    [self.tableView.mj_header beginRefreshing];
    
    __weak YQSocialViewController *weak_self = self;
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
         [weak_self requestNet:2];
    }];
}

#pragma 加载数据
- (void)loadTopBannerData
{
    NSString *urlstr = [NSString stringWithFormat:@"http://c.m.163.com/nc/article/headline/T1348647853363/0-10.html"];
   

    [[YQRequestTool shareRequestTool] setupRequestWithParameters:nil getPath:urlstr sussce:^(id responseObject) {
        NSArray *dataarray = [YQTopBannerDaTa mj_objectArrayWithKeyValuesArray:responseObject[@"T1348647853363"][0][@"ads"]];
        NSMutableArray *statusFrameArray = [NSMutableArray array];
        NSMutableArray *titleArray = [NSMutableArray array];
        NSMutableArray *topArray = [NSMutableArray array];
        for (YQTopBannerDaTa *data in dataarray) {
            [topArray addObject:data];
            [statusFrameArray addObject:data.imgsrc];
            [titleArray addObject:data.title];
        }
//        向bannerView添加数据
        [self.imagesArray addObjectsFromArray:statusFrameArray];
        [self.topArray addObjectsFromArray:topArray];
        [self.titleArray addObjectsFromArray:titleArray];
        
        self.bannerView.aryImg = [self.imagesArray copy];
        self.bannerView.aryText = [self.titleArray copy];
        
    } failure:^(id error) {
        
    }];
}

-(void)requestNet:(int)type
{
    IMP_BLOCK_SELF(YQSocialViewController);
    NSString *urlstr = [NSString stringWithFormat:@"http://c.m.163.com/nc/article/headline/T1348647853363/%d-20.html",self.page];
    
    [[YQRequestTool shareRequestTool] setupRequestWithParameters:nil getPath:urlstr sussce:^(id responseObject) {
        NSArray *temArray = responseObject[@"T1348647853363"];
        NSArray *arrayM = [YQTotalDaTaModel mj_objectArrayWithKeyValuesArray:temArray];
        NSMutableArray *statusArray = [NSMutableArray array];
        for (YQTotalDaTaModel *data in arrayM) {
            [statusArray addObject:data];
        }
        
        if (type == 1) {
            block_self.totalArray = statusArray;
        }else{
            [block_self.totalArray addObjectsFromArray:statusArray];
        }
        [block_self.tableView reloadData];
        block_self.page += 20;
        
        [block_self.tableView.mj_header endRefreshing];
        [block_self.tableView.mj_footer endRefreshing];
        
    } failure:^(id error) {
        if (error) {
            YQLog(@"%@",error);
        }
        [block_self.tableView.mj_header endRefreshing];
        [block_self.tableView.mj_footer endRefreshing];
        
    }];

    
}


#pragma mark 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.totalArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YQTotalDaTaModel *newsModel = self.totalArray[indexPath.row];
    
    NSString *ID = [YQNewsCell idForRow:newsModel];
    
    if ([ID isEqualToString:@"NewsCell"]) {
        
        YQNewsCell *cell = [YQNewsCell cellWithTableView:tableView];
        
        cell.dataModel = newsModel;
        return cell;
        
    }else if ([ID isEqualToString:@"ImagesCell"]){
        
        YQImagesCell *cell = [YQImagesCell cellWithTableView:tableView];
        cell.dataModel = newsModel;
        return cell;
    }
    else if ([ID isEqualToString:@"TopImageCell"]){
    
        YQTopCell *cell = [YQTopCell cellWithTableView:tableView];
        
        return cell;
        
    }
    else if([ID isEqualToString:@"TopTxtCell"]){
    
        YQTopCell *cell = [YQTopCell cellWithTableView:tableView];
        return cell;
        
    }
    else{
        YQBigImageCell *cell = [YQBigImageCell cellWithTableView:tableView];
        
        cell.dataModel = newsModel;
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    YQTotalDaTaModel *data = self.totalArray[indexPath.row];
    
    NSString *ID = [YQNewsCell idForRow:data];
    
    if ([ID isEqualToString:@"NewsCell"]) {
        
        YQDetailWebController *detailVC = [[YQDetailWebController alloc]init];
        detailVC.dataModel = self.totalArray[indexPath.row];
        detailVC.view.backgroundColor = [UIColor whiteColor];
        [self.navigationController pushViewController:detailVC animated:YES];
        
    }else if ([ID isEqualToString:@"ImagesCell"]){
        
        NSString *url1 = [data.photosetID substringFromIndex:4];
        url1 = [url1 substringToIndex:4];
        NSString *url2 = [data.photosetID substringFromIndex:9];
        YQLog(@"%@,%@",url1,url2);
        
        url2 = [NSString stringWithFormat:@"http://c.3g.163.com/photo/api/set/%@/%@.json",url1,url2];
        YQShowTopBannerController *topVC = [[YQShowTopBannerController alloc]init];
        topVC.url = url2;
        [self.navigationController pushViewController:topVC animated:YES];
        
    }else if ([ID isEqualToString:@"TopImageCell"]){
    }else{
        
        YQDetailWebController *detailVC = [[YQDetailWebController alloc]init];
        detailVC.dataModel = self.totalArray[indexPath.row];
        detailVC.view.backgroundColor = [UIColor whiteColor];
        [self.navigationController pushViewController:detailVC animated:YES];
        
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YQTotalDaTaModel *newsModel = self.totalArray[indexPath.row];
    
    CGFloat rowHeight = [YQNewsCell heightForRow:newsModel];
    
    return rowHeight;
}

#pragma mark 懒加载
- (NSMutableArray *)totalArray
{
    if (!_totalArray) {
        _totalArray = [NSMutableArray array];
    }
    return _totalArray;
}
- (NSMutableArray *)imagesArray
{
    if (!_imagesArray) {
        _imagesArray = [NSMutableArray array];
    }
    return _imagesArray;
}
- (NSMutableArray *)titleArray
{
    if (!_titleArray) {
        _titleArray = [NSMutableArray array];
    }
    return _titleArray;
}
- (NSMutableArray *)topArray
{
    if (!_topArray) {
        _topArray = [NSMutableArray array];
    }
    return _topArray;
}
@end
