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

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.showsHorizontalScrollIndicator = NO;
}

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
