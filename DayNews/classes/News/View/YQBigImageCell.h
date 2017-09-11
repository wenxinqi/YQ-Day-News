//
//  YQBigImageCell.h
//  DayNews
//
//  Created by 奇奇 on 2017/9/5.
//  Copyright © 2017年 奇奇. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YQTotalDaTaModel;
@interface YQBigImageCell : UITableViewCell
@property (nonatomic , strong) YQTotalDaTaModel *dataModel;
/**
 *  标题
 */
@property (nonatomic , weak) UILabel *titleL;
/**
 *  描述
 */
@property (nonatomic , weak) UILabel *lblSubtitle;
/**
 *  跟帖
 */
@property (nonatomic , weak) UILabel *lblReply;
/**
 *  大图
 */
@property (nonatomic , weak) UIImageView *image1;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
