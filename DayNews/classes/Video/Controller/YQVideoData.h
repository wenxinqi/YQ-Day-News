//
//  YQVideoData.h
//  DayNews
//
//  Created by 奇奇 on 2017/8/6.
//  Copyright © 2017年 奇奇. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YQVideoData : NSObject
//创建数据模型

/**
 videoTitle
 */
@property (nonatomic, copy) NSString *videoTitle;

//video的总时长
@property (nonatomic, copy) NSString *lengthTime;

//topic的image的url
@property (nonatomic, copy) NSString *topicImage;

//topic的title
@property (nonatomic, copy) NSString *topicTitle;

//video日期
@property (nonatomic, copy) NSString *videoDate;


@end
