//
//  YQVideoTableViewCell.h
//  DayNews
//
//  Created by 奇奇 on 2017/8/6.
//  Copyright © 2017年 奇奇. All rights reserved.
//

#import <UIKit/UIKit.h>






@class YQVideoData;
@interface YQVideoTableViewCell : UITableViewCell

//模型数组
@property (nonatomic , strong) YQVideoData *videoData;



//+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
