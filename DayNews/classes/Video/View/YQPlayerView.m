//
//  YQPlayerView.m
//  DayNews
//
//  Created by 奇奇 on 2017/8/25.
//  Copyright © 2017年 奇奇. All rights reserved.
//

#import "YQPlayerView.h"
#import "YQVideoData.h"
#import <AVFoundation/AVFoundation.h>

@interface YQPlayerView()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *playOrpause;
@property (weak, nonatomic) IBOutlet UILabel *timerLabel;
@property (weak, nonatomic) IBOutlet UISlider *slider;
@property (weak, nonatomic) IBOutlet UIButton *fullScreenBtn;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIView *bottomTool;

//创建一个avplayer
@property (nonatomic , strong) AVPlayer *player;
@property (nonatomic , strong) AVPlayerLayer *playerLayer;
@property (nonatomic , strong) AVPlayerItem *playerItem;

//定时器
@property (nonatomic , strong) NSTimer *timer;

@property (nonatomic, assign,getter=isShowBottomTool) BOOL isShowBottomTool;
@property (nonatomic, assign,getter=isFullScreen) BOOL isFullScreen;
@end

@implementation YQPlayerView

//重写初始化方法，添加额外信息
- (instancetype)init
{
    if (self = [super init]) {

    }
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([YQPlayerView class]) owner:nil options:nil].lastObject;
}

- (void)tapImageView
{
//    控制bottom的隐藏和显示
    [UIView animateWithDuration:0.5 animations:^{
        if (self.isShowBottomTool) {
            self.bottomTool.alpha = 0;
            self.isShowBottomTool = NO;
        }else{
            self.bottomTool.alpha = 1;
            self.isShowBottomTool = YES;
        }
    }];
    
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    //        给imageView添加一个点击事件
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageView)];
    self.imageView.userInteractionEnabled = YES;
    [self.imageView addGestureRecognizer:tap];
    
    
}

#pragma mark 当传入值时，就会进入set方法中
- (void)setTitle:(NSString *)title
{
    _title = title;
    _titleLabel.text = _title;
    
}

- (void)setMp4_url:(NSString *)mp4_url
{
//    不能使用self.mp4_url,不然会导致循环引用
    _mp4_url = mp4_url;
    self.player = [AVPlayer playerWithPlayerItem:[self getPlayerItem]];
    [self.imageView.layer addSublayer:self.playerLayer];
    [self.player play];
}

- (void)setMp4_length:(NSInteger)mp4_length
{
    _mp4_length = mp4_length;
    
#warning     开启定时器
    [self startTimer];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.playerLayer.frame = self.bounds;
}


//移除playerView
- (void)removePlayerView
{
    [self.player pause];
    [self.player.currentItem cancelPendingSeeks];
    [self.player.currentItem.asset cancelLoading];
    [self removeFromSuperview];
}

- (void)dealloc
{
    [self removePlayerView];
    self.player = nil;
}

- (AVPlayerLayer *)playerLayer
{
    if (!_playerLayer) {
        self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:_player];
        self.playerLayer.frame = self.bounds;
        
        self.playerLayer.backgroundColor = [UIColor blackColor].CGColor ;
        self.playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;  //填充整个视频layer
        
    }
    return _playerLayer;
}

- (AVPlayerItem *)getPlayerItem
{
//    将mp4——url转成playerItem，资源来自网络
    
    if ([self.mp4_url rangeOfString:@"http"].location != NSNotFound) {
        AVPlayerItem *playerItem = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:[self.mp4_url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]]];
        self.playerItem = playerItem;
        return playerItem;
    }else {
//        资源来自本地
        AVAsset *asset =  [[AVURLAsset alloc] initWithURL:[NSURL fileURLWithPath:self.mp4_url] options:nil];
        AVPlayerItem *playItem = [AVPlayerItem playerItemWithAsset:asset];
        
        return playItem;
    }
}
- (IBAction)clickPlayOrPauseBtn{
//    设置按钮的选中状态
    self.playOrpause.selected = !self.playOrpause.isSelected;
    
    if (self.playOrpause.selected == YES) {
        [self.player pause];
        
//        当暂停时停止定时器
        [self removeTimer];
    }else{
        [self.player play];
        
//        开启定时器
        [self startTimer];
    }
}
- (IBAction)clickIsFullBtn:(UIButton *)sender {
//    当点击全屏按钮时，view进行一个旋转动画
    sender.selected = !sender.isSelected;
    self.isFullScreen = sender.selected;
    if ([self.delegate respondsToSelector:@selector(videoPlayerScreenOrientation:)]) {
//        告诉代理做事
        [self.delegate videoPlayerScreenOrientation:sender.selected];
    }
    
}

//当slider的值发生改变时，进入这个方法
- (IBAction)touchSlider {
    
    NSTimeInterval currentTime = CMTimeGetSeconds(self.player.currentItem.duration) * self.slider.value;
    
#warning 拖动slider后，设置当前播放时间
    [self.player seekToTime:CMTimeMakeWithSeconds(currentTime, NSEC_PER_SEC) toleranceBefore:kCMTimeZero toleranceAfter:kCMTimeZero];
}

#pragma mark 定时器操作
//开启定时器
- (void)startTimer
{
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(upddateTimerLabel) userInfo:nil repeats:YES];

    self.timer = timer;
    [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}

- (void)upddateTimerLabel
{
//    self.timerLabel.text = [self timeString];
    self.timerLabel.text = [NSString stringWithFormat:@"%@/%@",[self timeString],[NSDate convertTime:self.mp4_length]];
    self.slider.value = CMTimeGetSeconds(self.player.currentTime) / CMTimeGetSeconds(self.player.currentItem.duration);
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        if ([self timeString] == [NSDate convertTime:self.mp4_length]) {
            [self removePlayerView];
            
            if (self.isFullScreen) {
                [[UIApplication sharedApplication].keyWindow.rootViewController dismissViewControllerAnimated:YES completion:nil];
            }
        }
        
    });
    
}
- (void)removeTimer
{
    [self.timer invalidate];
    self.timer = nil;
}

- (NSString *)timeString
{
//    NSTimeInterval duration = CMTimeGetSeconds(self.player.currentItem.duration);
    NSTimeInterval currentTime = CMTimeGetSeconds(self.player.currentTime);
    
    return [self stringWithCurrentTime:currentTime];
}

//将时间转为需要的格式
- (NSString *)stringWithCurrentTime:(NSTimeInterval)currentTime {
//    NSInteger dMin = duration / 60;
//    NSInteger dSec = (NSInteger)duration % 60;
    
    NSInteger cMin = currentTime / 60;
    NSInteger cSec = (NSInteger)currentTime % 60;
    
//    NSString *durationString = [NSString stringWithFormat:@"%02ld:%02ld", dMin, dSec];
    NSString *currentString = [NSString stringWithFormat:@"%02ld:%02ld", cMin, cSec];
    
//    return [NSString stringWithFormat:@"%@/%@", currentString, durationString];
    return [NSString stringWithFormat:@"%@", currentString];
}

#pragma mark layz
- (AVPlayer *)player
{
    if (!_player) {
        //    在imageView的layer上添加player的layer
        self.player = [[AVPlayer alloc] init];
        
    }
    return _player;
}
@end
