//
//  NSDate+YQExtension.h
//  DayNews
//
//  Created by 奇奇 on 2017/8/26.
//  Copyright © 2017年 奇奇. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (YQExtension)
/**
 *  是否为今天
 */
- (BOOL)isToday;
/**
 *  是否为昨天
 */
- (BOOL)isYesterday;
/**
 *  是否为今年
 */
- (BOOL)isThisYear;

/**
 *  获得与当前时间的差距
 */
- (NSDateComponents *)deltaWithNow;

-(NSDate *)dateWithYMD;

/**
 *  获取收藏的时间
 */
+ (NSString *)currentTime;


/**
 将传入的时间戳转化为HH:mm:ss的格式
 */
+ (NSString *)convertTime:(CGFloat)second;
@end
