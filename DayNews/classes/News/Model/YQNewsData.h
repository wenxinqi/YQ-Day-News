//
//  YQNewsData.h
//  DayNews
//
//  Created by 奇奇 on 2017/9/5.
//  Copyright © 2017年 奇奇. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YQNewsData : NSObject
//创建的时间
@property (nonatomic , copy) NSString *ctime;
//图片的url
@property (nonatomic , copy) NSString *picUrl;
//新闻的标题
@property (nonatomic , copy) NSString *title;
//新闻内容的url
@property (nonatomic , copy) NSString *url;
@end
