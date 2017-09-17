//
//  YQStartViewController.m
//  DayNews
//
//  Created by 奇奇 on 2017/9/17.
//  Copyright © 2017年 奇奇. All rights reserved.
//

#import "YQStartViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AVKit/AVKit.h>
#import "YQTabBarController.h"

@interface YQStartViewController ()
@property (nonatomic , strong) AVPlayer  *player;
@property (nonatomic , strong) AVPlayerItem *playerItem;
@end

@implementation YQStartViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//   在view上添加一个视频播放器
    [self setupPlayer];
    
//   监听播放器的播放结束状态
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playerItemDidReachEnd:) name:AVPlayerItemDidPlayToEndTimeNotification object:self.playerItem];

}

- (void)playerItemDidReachEnd:(NSNotification *)note
{
    [self clickEnterMainBtn];
}


- (void)setupPlayer
{
    
    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithURL:_url];
    self.player = [AVPlayer playerWithPlayerItem:playerItem];
    self.playerItem = playerItem;
    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    playerLayer.frame = self.view.bounds;
    
    [self.view.layer addSublayer:playerLayer];
    [self.player play];
    
//    在layer添加一个按钮
    UIButton *enterMainBtn = [[UIButton alloc] init];
    enterMainBtn.frame = CGRectMake(24, [UIScreen mainScreen].bounds.size.height - 32 - 48, [UIScreen mainScreen].bounds.size.width - 48, 48);
    enterMainBtn.layer.borderWidth = 1.0f;
    enterMainBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    enterMainBtn.layer.cornerRadius = 24;
    enterMainBtn.alpha = 0;
    [enterMainBtn setTitle:@"进入应用" forState:UIControlStateNormal];
    
//    给btn添加一个点击事件
    [enterMainBtn addTarget:self action:@selector(clickEnterMainBtn) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:enterMainBtn];
    
    [UIView animateWithDuration:3.0 animations:^{
        enterMainBtn.alpha = 1.0;
    }];
}

- (void)clickEnterMainBtn{
    
    [self.player pause];
    self.player = nil;
    
    YQTabBarController *tabBarVc = [[YQTabBarController alloc] init];
    tabBarVc.tabBar.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha: 1];
    
    [UIApplication sharedApplication].keyWindow.rootViewController = tabBarVc;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
