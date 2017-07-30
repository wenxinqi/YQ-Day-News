//
//  YQMeViewController.m
//  DayNews
//
//  Created by 奇奇 on 2017/7/19.
//  Copyright © 2017年 奇奇. All rights reserved.
//

#import "YQMeViewController.h"
#import "YQHeaderView.h"

@interface YQMeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic , strong) NSArray *YQGroups;
@end

@implementation YQMeViewController

//设置ID
static NSString *ID = @"cell";
- (void)viewDidLoad {
    [super viewDidLoad];
    //因为YQMeViewcontroller是navigationdontoller的子控制器，所以可以修改
    self.navigationController.navigationBarHidden = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.dataSource = self;
    
    //设置tableview的内边距
    
    //添加一个自定义的view在头部
    YQHeaderView *headerV = [YQHeaderView headerView];
    self.tableView.tableHeaderView = headerV;

}

#pragma mark -tableview数据源方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return  2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 2;
    }else{
        return 4;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                      reuseIdentifier:@"cell"];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    

    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell.imageView.image = [UIImage imageNamed:@"MorePush"];
            cell.textLabel.text = @"收藏";
        }else if (indexPath.row == 1){
            cell.imageView.image = [UIImage imageNamed:@"handShake"];
            cell.textLabel.text = @"夜间模式";
            cell.accessoryView = [[UISwitch alloc] init];
            
        }
        
    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            cell.imageView.image = [UIImage imageNamed:@"MoreHelp"];
            cell.textLabel.text = @"帮助与反馈";
        }else if (indexPath.row == 1){
            cell.imageView.image = [UIImage imageNamed:@"MoreShare"];
            cell.textLabel.text = @"分享给好友";
            
        }else if (indexPath.row == 2){
            cell.imageView.image = [UIImage imageNamed:@"handShake"];
            cell.textLabel.text = @"清理缓存";
        }else if (indexPath.row == 3){
            cell.imageView.image = [UIImage imageNamed:@"MoreAbout"];
            cell.textLabel.text = @"关于";
        }

    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return 20;
    }else{
        return 0;
    }
}
@end
