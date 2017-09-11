//
//  YQNewsData.m
//  DayNews
//
//  Created by 奇奇 on 2017/9/5.
//  Copyright © 2017年 奇奇. All rights reserved.
//

#import "YQNewsData.h"

@implementation YQNewsData
-(NSString *)ctime
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd HH:mm";
    // fmt.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"en_US"];
    NSDate *createdDate = [fmt dateFromString:_ctime];
    
    // 判断和现在时间的差距
    if (createdDate.isToday) {
        // 今天
        if (createdDate.deltaWithNow.hour >= 1)
        {
            return [NSString stringWithFormat:@"%ld小时前", (long)createdDate.deltaWithNow.hour];
        } else if (createdDate.deltaWithNow.minute >= 1)
        {
            return [NSString stringWithFormat:@"%ld分钟前", (long)createdDate.deltaWithNow.minute];
        } else {
            return @"刚刚";
        }
    } else if (createdDate.isYesterday) { // 昨天
        fmt.dateFormat = @"昨天 HH:mm";
        return [fmt stringFromDate:createdDate];
    } else if (createdDate.isThisYear) { // 今年(至少是前天)
        fmt.dateFormat = @"MM-dd HH:mm";
        return [fmt stringFromDate:createdDate];
    } else { // 非今年
        fmt.dateFormat = @"yyyy-MM-dd HH:mm";
        return [fmt stringFromDate:createdDate];
    }
    
}
@end
