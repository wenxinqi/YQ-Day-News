//
//  YQHTTPSessionManager.m
//  DayNews
//
//  Created by 奇奇 on 2017/8/31.
//  Copyright © 2017年 奇奇. All rights reserved.
//

#import "YQHTTPSessionManager.h"

@implementation YQHTTPSessionManager
#warning 添加子类，使之可以处理html的返回数据类型
+ (instancetype)manager {
    
    YQHTTPSessionManager *mgr = [super manager];
    // 创建NSMutableSet对象
    NSMutableSet *newSet = [NSMutableSet set];
    // 添加我们需要的类型
    newSet.set = mgr.responseSerializer.acceptableContentTypes;
    [newSet addObject:@"text/html"];
    
    // 重写给 acceptableContentTypes赋值
    mgr.responseSerializer.acceptableContentTypes = newSet;
    
    return mgr;
}


@end
