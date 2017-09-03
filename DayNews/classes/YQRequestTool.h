//
//  YQRequestTool.h
//  DayNews
//
//  Created by 奇奇 on 2017/8/24.
//  Copyright © 2017年 奇奇. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YQRequestTool : NSObject

+ (instancetype)shareRequestTool;

- (void)setupRequestWithParameters:(NSDictionary *)para getPath:(NSString *)path sussce:(void(^)(id responseObject))sussce failure:(void(^)(id error))failure;
@end
