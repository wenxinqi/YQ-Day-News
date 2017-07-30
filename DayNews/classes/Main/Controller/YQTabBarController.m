//
//  YQTabBarController.m
//  DayNews
//
//  Created by 奇奇 on 2017/7/19.
//  Copyright © 2017年 奇奇. All rights reserved.
//

#import "YQTabBarController.h"
#import "YQNewsViewController.h"
#import "YQVideoViewController.h"
#import "YQPictureViewController.h"
#import "YQMeViewController.h"
#import "YQNavigationController.h"

@interface YQTabBarController ()

@end

@implementation YQTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableDictionary *atrrs = [NSMutableDictionary dictionary];
    atrrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    atrrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    NSMutableDictionary *selectAtrrs = [NSMutableDictionary dictionary];
    selectAtrrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    selectAtrrs[NSForegroundColorAttributeName] = [UIColor redColor];
    
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:atrrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectAtrrs forState:UIControlStateSelected];
    
    //给tabbar添加子控制器
    [self setChildVc:[[YQNewsViewController alloc] init] Title:@"新闻" image:@"tabbar_news" selectedImage:@"tabbar_news_hl"];
    
    [self setChildVc:[[YQVideoViewController alloc] init] Title:@"视频" image:@"tabbar_video" selectedImage:@"tabbar_video_hl"];
    
    [self setChildVc:[[YQPictureViewController alloc] init] Title:@"图片" image:@"tabbar_picture" selectedImage:@"tabbar_picture_hl"];
    
    [self setChildVc:[[YQMeViewController alloc] init] Title:@"我" image:@"tabbar_setting" selectedImage:@"tabbar_setting_hl"];
    
   
}

- (void)setChildVc:(UIViewController *)vc Title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:image];
    vc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    
    //给tabbarcontroller添加子控件
    
    YQNavigationController *naVc = [[YQNavigationController alloc] initWithRootViewController:vc];
    
    [self addChildViewController:naVc];
    
}

@end
