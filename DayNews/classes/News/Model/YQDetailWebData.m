//
//  YQDetailWebData.m
//  DayNews
//
//  Created by 奇奇 on 2017/9/5.
//  Copyright © 2017年 奇奇. All rights reserved.
//

#import "YQDetailWebData.h"
#import "YQDetailWebImageData.h"

@implementation YQDetailWebData
+ (instancetype)detailWithDict:(NSDictionary *)dict
{
    YQDetailWebData *detail = [[self alloc]init];
    detail.title = dict[@"title"];
    detail.ptime = dict[@"ptime"];
    detail.body = dict[@"body"];
    
    NSArray *imgArray = dict[@"img"];
    NSMutableArray *temArray = [NSMutableArray arrayWithCapacity:imgArray.count];
    
    for (NSDictionary *dict in imgArray) {
        YQDetailWebImageData *imgModel = [YQDetailWebImageData detailImgWithDict:dict];
        [temArray addObject:imgModel];
    }
    detail.img = temArray;
    
    return detail;
}
@end
