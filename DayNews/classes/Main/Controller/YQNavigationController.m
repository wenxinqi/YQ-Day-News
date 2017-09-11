//
//  YQNavigationController.m
//  DayNews
//
//  Created by 奇奇 on 2017/7/20.
//  Copyright © 2017年 奇奇. All rights reserved.
//

#import "YQNavigationController.h"

@interface YQNavigationController ()

@end

@implementation YQNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
//    设置导航栏的背景色
    self.navigationBar.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha: 1];
}

//重写navigationController的push方法
//- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
//{
//    if (self.childViewControllers.count > 0) { // 如果push进来的不是第一个控制器
//        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//        [button setTitle:@"返回" forState:UIControlStateNormal];
//        [button setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
//        [button setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];
//        button.size = CGSizeMake(70, 30);
//        // 让按钮内部的所有内容左对齐
//        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//        //        [button sizeToFit];
//        
//        // 让按钮的内容往左边偏移10
//        button.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
//        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        [button setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
//        [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
//        
//        // 修改导航栏左边的item
//        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
//        
//        // 隐藏tabbar
//        viewController.hidesBottomBarWhenPushed = YES;
//    }
////    [super pushViewController:viewController animated:YES];
//}

//- (void)back
//{
//    [self popViewControllerAnimated:YES];
//}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count) {
        viewController.hidesBottomBarWhenPushed = YES;
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem ItemWithIcon:@"navigationbar_back_os7" highIcon:nil target:self action:@selector(back)];
        
    }
    
    [super pushViewController:viewController animated:animated];
    
}

- (void)back
{
    
    [self popViewControllerAnimated:YES];
}


@end
