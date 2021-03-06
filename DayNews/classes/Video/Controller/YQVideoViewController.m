//
//  YQVideoViewController.m
//  DayNews
//
//  Created by 奇奇 on 2017/7/20.
//  Copyright © 2017年 奇奇. All rights reserved.
//

#import "YQVideoViewController.h"
#import "YQVideoHeaderView.h"
#import "YQVideoTableViewCell.h"
#import "YQVideoData.h"
#import "YQRequestTool.h"
#import "YQPlayerView.h"
#import "YQFullViewController.h"


#warning 显示的网页有重复元素
#define rgba(r,g,b,a)  [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

@interface YQVideoViewController ()<UITableViewDelegate,UITableViewDataSource,YQVideoFullScreenDelegate>

//创建一个可变数组存放请求返回的数据
@property (nonatomic , strong) NSMutableArray *videoDateArray;
//playerView
@property (nonatomic , strong) YQPlayerView  *playerView;

@property (nonatomic, assign) int count;

@property (nonatomic , strong) YQFullViewController *fullVc;
//当前选中行
@property (nonatomic , strong) NSIndexPath *indexPath;


//默认的请求行
@property (nonatomic, copy) NSString *url;

//点击headerView后发送的参数
@property (nonatomic, copy) NSString *params;
@end

@implementation YQVideoViewController

//对videoDateArray懒加载
- (NSMutableArray *)videoDateArray
{
    if (_videoDateArray == nil ) {
        _videoDateArray = [NSMutableArray array];
    }
    return _videoDateArray;
}

/**
 1、添加一个headerview 
 2、自定义cell
 3、发送请求数据，将返回的数据转化为模型数据
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    
//    tableView的基本设置
    [self setupTableView];
    
//    刷新
    [self setupRefresh];
    
    
}

//创建刷新的header和footer
- (void)setupRefresh
{
//    count==0 ， 刷新首页,默认数据
    _url = [NSString stringWithFormat:@"http://c.m.163.com/nc/video/home/%d-10.html",self.count];
    _params = @"videoList";
//  header
    YQRefreshGifController *header = [YQRefreshGifController headerWithRefreshingBlock:^{
        self.count = 0;
        [self loadVideoDataWithURL:self.url parameters:self.params];
        
    }];

    self.tableView.mj_header = header;
    
//    自动调整header的透明度
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    
//    当进入这个界面时就刷新
    [self.tableView.mj_header beginRefreshing];
    
//   footer
    self.tableView.tableFooterView = [[UIView alloc]init];

//会导致内存泄漏
    __weak YQVideoViewController *weak_self = self;
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weak_self loadVideoDataWithURL:self.url parameters:self.params];
     
    }];
    
}

//初始化tableView
static NSString *ID = @"cell";
- (void)setupTableView
{
    self.title = @"视频";
    self.tableView.backgroundColor = rgba(230, 230, 230, 1);
    
    //    设置tableview的headerview
    
    YQVideoHeaderView *videoHeader =  [[YQVideoHeaderView alloc] init];
    videoHeader.backgroundColor = [UIColor whiteColor];
    self.tableView.tableHeaderView = videoHeader;

    videoHeader.selectBtn = ^(NSInteger tag,NSString *title){
        
        NSArray *arr = @[@"VAP4BFE3U",
                         @"VAP4BFR16",
                         @"VAP4BG6DL",
                         @"VAP4BGTVD"];
        self.title = title;
        self.url = [NSString stringWithFormat:@"http://c.3g.163.com/nc/video/list/%@/y/%d-10.html",arr[tag],self.count];
        self.params = arr[tag];
        [self.tableView.mj_header beginRefreshing];
    };
   
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([YQVideoTableViewCell class]) bundle:nil] forCellReuseIdentifier:ID];
}

//刷新数据
//@"http://c.3g.163.com/nc/video/list/%@/y/%d-10.html",_url,self.count
//@"http://c.m.163.com/nc/video/home/%d-10.html",self.count
- (void)loadVideoDataWithURL:(NSString *)url  parameters:(NSString *)params
{
//如果点击了headerView,url有值
    
   
//    发送请求
    
    __weak YQVideoViewController *weak_self = self;
    
    [[YQRequestTool shareRequestTool] setupRequestWithParameters:nil getPath:url sussce:^(id responseObject) {

#warning      将返回数据转为模型数组
         NSArray *videoArray = [YQVideoData mj_objectArrayWithKeyValuesArray:responseObject[params]];
//        [self.videoDateArray addObjectsFromArray:videoArray];
        
        NSMutableArray *statusArray = [NSMutableArray array];
        for (YQVideoData *DataArray in videoArray) {
                [statusArray addObject:DataArray];
        }

        if (self.count == 0) {
            self.videoDateArray = statusArray;
        }else{
            [self.videoDateArray addObjectsFromArray:statusArray];
        }
        
//        加载下一页，一页的内容个数为10
        weak_self.count += 10;
//        数据更新：tableview刷新
        [weak_self.tableView reloadData];
        [weak_self.tableView.mj_header endRefreshing];
        [weak_self.tableView.mj_footer endRefreshing];
        weak_self.tableView.mj_footer.hidden = _videoDateArray.count < 10;
        
    } failure:^(id error) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
}



#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.videoDateArray.count;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YQVideoCellHeight;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//  YQVideoTableViewCell调用类方法创建cell
    YQVideoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

//   取出数据模型
    cell.videoData = _videoDateArray[indexPath.row];

    return cell;
}

#pragma mark UITableViewDelegate
//选中当前行
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    当选中cell后将YQPlayview添加到cell上
    self.indexPath = indexPath;
    YQPlayerView *playerView = [[YQPlayerView alloc] init];
    self.playerView = playerView;

//  设置playerview的Y值
    CGFloat originY = YQVideoCellHeight * indexPath.row + 100 + YQVideoCellMargin;
    CGRect rect = CGRectMake(0, originY, YQSCREEN_WIDTH, YQVideoCellHeight - 54);
    self.playerView.frame = rect;
    
    YQVideoData *videoData = self.videoDateArray[indexPath.row];
    self.playerView.mp4_url = videoData.mp4_url;
    self.playerView.title = videoData.title;
    self.playerView.mp4_length = videoData.length;
    
    self.playerView.delegate = self;
    
    [self.tableView addSubview:playerView];
    
    
}

//在tableView是单选模式下，当点击选中第二个时会自动取消之前选中的行，同时会进入这个方法
- (NSIndexPath *)tableView:(UITableView *)tableView willDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.playerView removePlayerView];
    return indexPath;
}


#pragma 全屏操作  YQvideopaleyerdelegate,isFull是传入的值
- (void)videoPlayerScreenOrientation:(BOOL)isFull
{
    self.fullVc = [[YQFullViewController alloc] init];
    
    if (isFull) {
//        当是全屏的时候，将playerview添加到YQFullVc上
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:_fullVc animated:YES completion:^{
            self.playerView.frame = self.fullVc.view.bounds;
            
            [_fullVc.view addSubview:self.playerView];
        }];
    }else{
        [[UIApplication sharedApplication].keyWindow.rootViewController dismissViewControllerAnimated:YES completion:^{
//            dismiss后将再将videoView添加到tableview上
            CGFloat originY = YQVideoCellHeight * _indexPath.row + 100 + YQVideoCellMargin;
            CGRect rect = CGRectMake(0, originY, YQSCREEN_WIDTH, YQVideoCellHeight - 54);
            self.playerView.frame = rect;

            [self.tableView addSubview:_playerView];
        }];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    如果当前滚动的y值大于playerView的Y值时移除playerView
    if (self.playerView) {
        if (fabs(scrollView.contentOffset.y)+20 > CGRectGetMaxY(self.playerView.frame)) {
            [self.playerView removePlayerView];
            self.playerView = nil;
        }
    }
}

#pragma mark - 懒加载代码

@end
