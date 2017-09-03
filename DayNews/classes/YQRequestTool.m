//
//  YQRequestTool.m
//  DayNews
//
//  Created by 奇奇 on 2017/8/24.
//  Copyright © 2017年 奇奇. All rights reserved.
//

#import "YQRequestTool.h"



//生成一个单例类
static id _instance;
@implementation YQRequestTool

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
//    加锁：防止多线程重入的情况下，造成静态变量多次分配内存和初始化，从而导致数据混乱
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    
    return _instance;
}

- (id)copyWithZone:(struct _NSZone *)zone
{
    return _instance;
}

+ (instancetype)shareRequestTool
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    
    return _instance;
}

//添加一个方法根据传入request发送请求,设置sussce和failure的block截获自动变量,
- (void)setupRequestWithParameters:(NSDictionary *)para getPath:(NSString *)path sussce:(void(^)(id responseObject))sussce failure:(void(^)(id error))failure
{
    YQHTTPSessionManager *mgr = [YQHTTPSessionManager manager];
   
    [mgr GET:path  parameters:para  progress:^(NSProgress * _Nonnull downloadProgress) {
      
  } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//      YQLog(@" %@ , %@",path , responseObject);
      sussce(responseObject);
  } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//      YQLog(@" %@ , %@",path ,error);
      failure(error);
    }];
}
@end
