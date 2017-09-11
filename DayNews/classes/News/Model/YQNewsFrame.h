//
//  YQNewsFrame.h
//  DayNews
//
//  Created by 奇奇 on 2017/9/5.
//  Copyright © 2017年 奇奇. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YQNewsData;
@interface YQNewsFrame : NSObject
@property (nonatomic , strong) YQNewsData *NewsData;

@property (nonatomic , assign) CGRect descriptionF;
@property (nonatomic , assign) CGRect picUrlF;
@property (nonatomic , assign) CGRect titleF;
@property (nonatomic , assign) CGRect urlF;
@property (nonatomic , assign) CGRect ctimeF;

@property (nonatomic , assign) CGFloat cellH;
@end
