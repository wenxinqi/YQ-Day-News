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

@interface YQVideoViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation YQVideoViewController


/**
 1、添加一个headerview 
 2、自定义cell
 3、发送请求数据，将返回的数据转化为模型数据
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    
//    tableView的基本设置
    [self setupTableView];
  
}

static  NSString *YQVideoCellID = @"cell";
- (void)setupTableView
{
    self.title = @"视频";
    self.tableView.backgroundColor = [UIColor lightGrayColor];
    
    //    设置tableview的headerview
    YQVideoHeaderView *videoHeader =  [[YQVideoHeaderView alloc] init];
    videoHeader.backgroundColor = [UIColor whiteColor];
    self.tableView.tableHeaderView = videoHeader;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
//    注册cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([YQVideoTableViewCell class]) bundle:nil] forCellReuseIdentifier:YQVideoCellID];
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 250;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//  YQVideoTableViewCell已经被注册为cell，也就是被初始化了
    YQVideoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:YQVideoCellID];
    
//   取出数据模型
    return cell;
}


@end
