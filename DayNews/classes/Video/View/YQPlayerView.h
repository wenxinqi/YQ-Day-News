//
//  YQPlayerView.h
//  DayNews
//
//  Created by 奇奇 on 2017/8/25.
//  Copyright © 2017年 奇奇. All rights reserved.
//

#import <UIKit/UIKit.h>

//声明一个代理
@protocol YQVideoFullScreenDelegate <NSObject>

@optional
- (void)videoPlayerScreenOrientation:(BOOL)isFull;

@end

@interface YQPlayerView : UIView

//title
@property (nonatomic , copy) NSString *title;
//url
@property (nonatomic , copy) NSString *mp4_url;
//视频的时间长度
@property (nonatomic, assign) NSInteger mp4_length;

@property (nonatomic , weak) id<YQVideoFullScreenDelegate> delegate;

- (void)removePlayerView;
@end
