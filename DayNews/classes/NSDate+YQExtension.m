//
//  NSDate+YQExtension.m
//  DayNews
//
//  Created by 奇奇 on 2017/8/26.
//  Copyright © 2017年 奇奇. All rights reserved.
//

#import "NSDate+YQExtension.h"

@implementation NSDate (YQExtension)
/**
 *  是否为今天
 */
-(BOOL)isToday
{
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitDay | NSCalendarUnitMonth |  NSCalendarUnitYear;
    
    // 1.获得当前时间的年月日
    NSDateComponents *nowCmps = [calendar components:unit fromDate:[NSDate date]];
    
    // 2.获得self的年月日
    NSDateComponents *selfCmps = [calendar components:unit fromDate:self];
    
    return(selfCmps.year == nowCmps.year) && (selfCmps.month == nowCmps.month) && (selfCmps.day == nowCmps.day);
}

/**
 *  是否为昨天
 */
-(BOOL)isYesterday
{
    
    NSDate *nowDate = [[NSDate date]dateWithYMD];
    NSDate *selfDate = [self dateWithYMD];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *cmps = [calendar components:NSCalendarUnitDay fromDate:selfDate toDate:nowDate options:0];
    
    return cmps.day == 1;
}

-(NSDate *)dateWithYMD
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    fmt.dateFormat = @"yyyy-MM-dd";
    NSString *str = [fmt stringFromDate:self];
    return [fmt dateFromString:str];
}

/**
 *  是否为今年
 */
-(BOOL)isThisYear
{
    
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitYear;
    
    // 1.获得当前时间的年月日
    NSDateComponents *nowCmps = [calendar components:unit fromDate:[NSDate date]];
    
    // 2.获得self的年月日
    NSDateComponents *selfCmps = [calendar components:unit fromDate:self];
    
    return nowCmps.year == selfCmps.year;
}

- (NSDateComponents *)deltaWithNow
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    return [calendar components:unit fromDate:self toDate:[NSDate date] options:0];
}

/**
 *  返回当前时间
 */
+ (NSString *)currentTime
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    fmt.dateFormat = @"MM-dd HH:mm";
    NSString *str = [fmt stringFromDate:[NSDate date]];
    return str;
}

//时间转换
+ (NSString *)convertTime:(CGFloat)second{
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    NSDate *d = [NSDate dateWithTimeIntervalSince1970:second];
    //设置时间格式
    if (second/3600 >= 1) {
        [fmt setDateFormat:@"HH:mm:ss"];
    } else {
        [fmt setDateFormat:@"mm:ss"];
    }
    NSString *showtimeNew = [fmt stringFromDate:d];
    return showtimeNew;
}
@end
