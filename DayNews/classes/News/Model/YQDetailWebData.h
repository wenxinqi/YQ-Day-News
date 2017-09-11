//
//  YQDetailWebData.h
//  DayNews
//
//  Created by 奇奇 on 2017/9/5.
//  Copyright © 2017年 奇奇. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YQDetailWebData : NSObject
/** 标题 */
@property (nonatomic, copy) NSString *title;
/** 发布时间 */
@property (nonatomic, copy) NSString *ptime;
/** 内容 */
@property (nonatomic, copy) NSString *body;
/** 配图 */
@property (nonatomic, strong) NSArray *img;

+ (instancetype)detailWithDict:(NSDictionary *)dict;
@end
