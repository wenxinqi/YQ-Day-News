//
//  YQFullViewController.m
//  DayNews
//
//  Created by 奇奇 on 2017/8/27.
//  Copyright © 2017年 奇奇. All rights reserved.
//

#import "YQFullViewController.h"

@interface YQFullViewController ()

@end

@implementation YQFullViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (instancetype)init
{
    if (self = [super init]) {
//        设置弹出全屏的样式
//        self.modalPresentationStyle = UIModalPresentationFullScreen;
    }
    return self;
}

//是否允许旋转
- (BOOL)shouldAutorotate
{
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscapeLeft;
}

@end
