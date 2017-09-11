//
//  YQTopBannerDaTa.h
//  DayNews
//
//  Created by 奇奇 on 2017/9/4.
//  Copyright © 2017年 奇奇. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YQTopBannerDaTa : NSObject
/**
 *  滚动条图片
 */
@property (nonatomic , copy) NSString *imgsrc;
/**
 *  滚动条标题
 */
@property (nonatomic , copy) NSString *title;
/**
 *  链接
 */
@property (nonatomic , copy) NSString *url;


/**
 *  imgurl  详细图片
 */
@property (nonatomic , copy) NSString *imgurl;
/**
 *  详细内容
 */
@property (nonatomic , copy) NSString *note;
/**
 *  标题
 */
@property (nonatomic , copy) NSString *setname;

@property (nonatomic , copy) NSString *imgtitle;

@end
