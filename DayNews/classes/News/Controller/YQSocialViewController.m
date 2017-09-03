//
//  YQSocialViewController.m
//  DayNews
//
//  Created by 奇奇 on 2017/7/27.
//  Copyright © 2017年 奇奇. All rights reserved.
//

#import "YQSocialViewController.h"

@interface YQSocialViewController ()

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

- (void)setupRefresh
{
    //    self.tableView.showsHorizontalScrollIndicator = NO;
    //    self.tableView.showsVerticalScrollIndicator = NO;
//    [[YQRequestTool shareRequestTool] setupRequestWithParameters:nil getPath:nil sussce:^(id responseObject) {
//        
//    } failure:^(id error) {
//        
//    }];
}
- (void)setupTableView
{

}

#pragma mark 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"testIndex  -- %ld",indexPath.row];
   
    return cell;
}

@end
